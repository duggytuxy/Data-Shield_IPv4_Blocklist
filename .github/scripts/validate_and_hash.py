#!/usr/bin/env python3
"""Verify the published IPv4 feeds and write SHA-256 digests of their exact bytes."""

import argparse
import hashlib
import ipaddress
import os
from pathlib import Path
import stat
import subprocess
import sys
import tempfile

PROFILES = {
    "prod_data-shield_ipv4_blocklist.txt": "prod_{}-data-shield_ipv4_blocklist.txt",
}
PART_SIZE = 30_000
MAX_RECORDS = 600_000
MAX_LINE_BYTES = 16  # Dotted-decimal IPv4, including its terminating LF.
CHECKSUMS = Path("sha256sums.txt")

# Apply the project's public-feed exclusions consistently across Python versions.
# These cover private, shared, special-purpose, documentation and reserved space.
EXCLUDED_NETWORKS = tuple(map(ipaddress.IPv4Network, (
    "0.0.0.0/8", "10.0.0.0/8", "100.64.0.0/10", "127.0.0.0/8",
    "169.254.0.0/16", "172.16.0.0/12", "192.0.0.0/24", "192.0.2.0/24",
    "192.31.196.0/24", "192.52.193.0/24", "192.88.99.0/24", "192.168.0.0/16",
    "192.175.48.0/24", "198.18.0.0/15", "198.51.100.0/24", "203.0.113.0/24",
    "224.0.0.0/4", "240.0.0.0/4",
)))


def is_feed_name(name):
    return name.startswith("prod_") and name.endswith("_ipv4_blocklist.txt")


def read_feed(name, max_records):
    limit = max_records * MAX_LINE_BYTES
    fd = os.open(name, os.O_RDONLY | os.O_NOFOLLOW | os.O_NONBLOCK)
    with os.fdopen(fd, "rb") as source:
        info = os.fstat(fd)
        if not stat.S_ISREG(info.st_mode) or info.st_size > limit:
            raise ValueError(f"{name}: expected a regular file of at most {limit} bytes")
        raw = source.read(limit + 1)
    if len(raw) > limit:
        raise ValueError(f"{name}: file exceeded {limit} bytes")
    return raw


def profile_lines(name, raw):
    if not raw or not raw.endswith(b"\n"):
        raise ValueError(f"{name}: expected a nonempty feed ending in LF")
    if raw.count(b"\n") > MAX_RECORDS:
        raise ValueError(f"{name}: too many IPv4 addresses")
    lines = raw[:-1].split(b"\n")
    previous = -1
    for number, line in enumerate(lines, 1):
        try:
            address = ipaddress.IPv4Address(line.decode("ascii"))
        except (UnicodeDecodeError, ipaddress.AddressValueError):
            raise ValueError(f"{name}:{number}: expected one IPv4 address") from None
        if str(address).encode("ascii") != line or any(address in network for network in EXCLUDED_NETWORKS):
            raise ValueError(f"{name}:{number}: expected a canonical public IPv4 address")
        value = int(address)
        if value <= previous:
            raise ValueError(f"{name}:{number}: duplicate or out-of-order IPv4 address")
        previous = value
    return lines


def validate_feeds():
    hashes = {}
    for full_name, pattern in PROFILES.items():
        raw = read_feed(full_name, MAX_RECORDS)
        lines = profile_lines(full_name, raw)
        hashes[full_name] = hashlib.sha256(raw).hexdigest()
        for index, start in enumerate(range(0, len(lines), PART_SIZE)):
            first, second = divmod(index, 26)
            suffix = chr(ord("a") + first) + chr(ord("a") + second)
            part_name = pattern.format(suffix)
            part = read_feed(part_name, PART_SIZE)
            expected = b"\n".join(lines[start:start + PART_SIZE]) + b"\n"
            if part != expected:
                raise ValueError(f"{part_name}: differs from the corresponding rows of {full_name}")
            hashes[part_name] = hashlib.sha256(part).hexdigest()
    extra = sorted(name for name in os.listdir(".") if is_feed_name(name) and name not in hashes)
    if extra:
        raise ValueError(f"Unexpected feed paths: {extra!r}")
    return hashes


def verify_git_head(hashes):
    """Reject missing Git paths and checkout transformations before uploading CI hashes."""
    listing = subprocess.check_output(["git", "ls-tree", "-z", "HEAD"])
    tracked = {}
    for entry in listing.split(b"\0"):
        if not entry:
            continue
        metadata, path = entry.split(b"\t", 1)
        name = os.fsdecode(path)
        if is_feed_name(name):
            if metadata.split()[0] not in (b"100644", b"100755"):
                raise ValueError(f"{name}: expected a regular file in Git")
            tracked[name] = metadata.split()[2].decode("ascii")
    if tracked.keys() != hashes.keys():
        raise ValueError("Published feed paths differ from the checked-out commit")
    for name, digest in hashes.items():
        object_id = tracked[name]
        size = int(subprocess.check_output(["git", "cat-file", "-s", object_id]))
        if size > MAX_RECORDS * MAX_LINE_BYTES:
            raise ValueError(f"{name}: Git blob exceeds the feed size limit")
        committed = subprocess.check_output(["git", "cat-file", "blob", object_id])
        if hashlib.sha256(committed).hexdigest() != digest:
            raise ValueError(f"{name}: validated bytes differ from the committed Git blob")


def write_checksums(hashes):
    contents = "".join(f"{digest}  {name}\n" for name, digest in sorted(hashes.items()))
    with tempfile.TemporaryDirectory(dir=".", prefix=".cia-integrity-") as directory:
        temporary = Path(directory) / CHECKSUMS
        temporary.write_bytes(contents.encode("ascii"))
        temporary.replace(CHECKSUMS)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--git-head", action="store_true", help="also verify Git HEAD for CI")
    args = parser.parse_args()
    hashes = validate_feeds()
    if args.git_head:
        verify_git_head(hashes)
    write_checksums(hashes)
    print(f"Verified {len(hashes)} feed files. Wrote {CHECKSUMS}.")


if __name__ == "__main__":
    try:
        main()
    except (OSError, ValueError, subprocess.CalledProcessError) as error:
        sys.exit(f"Integrity check failed: {error}")
