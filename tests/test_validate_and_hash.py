"""Test the public validator through the Bash command used by CI."""

import hashlib
import ipaddress
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

VALIDATOR = Path(__file__).resolve().parents[1] / ".github/scripts/validate_and_hash.sh"
STANDARD = "prod_data-shield_ipv4_blocklist.txt"
CRITICAL = "prod_critical_data-shield_ipv4_blocklist.txt"
STANDARD_PART = "prod_{}-data-shield_ipv4_blocklist.txt"
CRITICAL_PART = "prod_critical_{}_data-shield_ipv4_blocklist.txt"
SAMPLE = b"1.1.1.1\n8.8.8.8\n"


def public_lines(count):
    first = int(ipaddress.IPv4Address("11.0.0.1"))
    return [(str(ipaddress.IPv4Address(first + index)) + "\n").encode("ascii") for index in range(count)]


class FeedIntegrityTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        self.sums = self.root / "sha256sums.txt"
        for name in (STANDARD, STANDARD_PART.format("aa")):
            self.write(name, SAMPLE)

    def write(self, name, data):
        (self.root / name).write_bytes(data)

    def run_validator(self, *args):
        return subprocess.run(["bash", str(VALIDATOR), *args], cwd=self.root,
                              capture_output=True, text=True, timeout=20)

    def assert_rejected(self, *args):
        previous = self.sums.read_bytes() if self.sums.exists() else None
        result = self.run_validator(*args)
        self.assertNotEqual(result.returncode, 0, result.stdout)
        self.assertIn("Integrity check failed", result.stderr)
        if previous is None:
            self.assertFalse(self.sums.exists())
        else:
            self.assertEqual(self.sums.read_bytes(), previous)

    def git(self, *args):
        command = ["git", "-c", "core.hooksPath=/dev/null", "-c", "commit.gpgsign=false",
                   "-c", "user.name=CI test", "-c", "user.email=ci@example.invalid", *args]
        subprocess.run(command, cwd=self.root, capture_output=True, check=True)

    def test_valid_bytes_permissions_and_checksums(self):
        expected = {}
        for path in self.root.iterdir():
            path.chmod(0o640)
            expected[path.name] = hashlib.sha256(path.read_bytes()).hexdigest()
        result = self.run_validator()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.sums.read_text(), "".join(
            f"{expected[name]}  {name}\n" for name in sorted(expected)))
        for name in expected:
            path = self.root / name
            self.assertEqual(path.read_bytes(), SAMPLE)
            self.assertEqual(path.stat().st_mode & 0o777, 0o640)

    def test_reject_format_errors_without_repairing_input(self):
        self.sums.write_text("Previous checksums.\n")
        malformed = [
            b"", b"\n", b"8.8.8.8", b"8.8.8.8\r\n", b"8.8.8.8\n\n", b" 8.8.8.8\n",
            b"8.8.8.8 \n", b"8.8.8.8\t\n", b"8.8.8.8/32\n", b"8.8.8.256\n", b"1.1.1\n",
            b"001.1.1.1\n", b"::1\n", b"example.org\n", b"# comment\n", b"\xff\n",
            b"8.8.8.8\n8.8.8.8\n", b"8.8.8.8\n1.1.1.1\n",
        ]
        for raw in malformed:
            with self.subTest(raw=raw):
                self.write(STANDARD, raw)
                self.write(STANDARD_PART.format("aa"), raw)
                self.assert_rejected()
                self.assertEqual((self.root / STANDARD).read_bytes(), raw)

    def test_reject_private_and_special_use_networks(self):
        for address in ("0.0.0.0", "10.255.255.255", "100.64.0.1", "127.0.0.1",
                        "169.254.0.1", "172.31.255.255", "192.0.0.9", "192.0.2.1",
                        "192.31.196.1", "192.52.193.1", "192.88.99.1", "192.168.1.1",
                        "192.175.48.1", "198.19.255.255", "198.51.100.1", "203.0.113.1",
                        "224.0.0.1", "239.255.255.255", "240.0.0.1", "255.255.255.255"):
            with self.subTest(address=address):
                raw = (address + "\n").encode("ascii")
                self.write(STANDARD, raw)
                self.write(STANDARD_PART.format("aa"), raw)
                self.assert_rejected()

    def test_standard_and_its_first_part_are_required(self):
        for name in (STANDARD, STANDARD_PART.format("aa")):
            with self.subTest(name=name):
                (self.root / name).unlink()
                self.assert_rejected()
                self.write(name, SAMPLE)
        for path in self.root.iterdir():
            path.unlink()
        self.assert_rejected()

    def test_exact_part_boundary_and_partial_last_part(self):
        lines = public_lines(30_001)
        self.write(STANDARD, b"".join(lines[:30_000]))
        self.write(STANDARD_PART.format("aa"), b"".join(lines[:30_000]))
        result = self.run_validator()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.write(STANDARD, b"".join(lines))
        self.write(STANDARD_PART.format("ab"), lines[-1])
        result = self.run_validator()
        self.assertEqual(result.returncode, 0, result.stderr)
        expected = {p.name for p in self.root.iterdir() if p != self.sums}
        self.assertEqual({line.split()[1] for line in self.sums.read_text().splitlines()}, expected)
        self.write(STANDARD_PART.format("ab"), lines[-2])
        self.assert_rejected()
        self.write(STANDARD_PART.format("ab"), lines[-1])
        self.write(STANDARD_PART.format("aa"), b"".join(lines))
        self.assert_rejected()

    def test_reject_holes_stale_parts_and_wrong_names(self):
        for name in (STANDARD_PART.format("ab"), CRITICAL, CRITICAL_PART.format("aa"), CRITICAL_PART.format("ad"),
                     "prod_data_ab-shield_ipv4_blocklist.txt", "prod_b-data-shield_ipv4_blocklist.txt"):
            with self.subTest(name=name):
                self.write(name, SAMPLE)
                self.assert_rejected()
                (self.root / name).unlink()
        (self.root / STANDARD_PART.format("aa")).rename(self.root / STANDARD_PART.format("ab"))
        self.assert_rejected()

    def test_middle_part_is_required_when_later_parts_exist(self):
        lines = public_lines(60_001)
        self.write(STANDARD, b"".join(lines))
        for start, suffix in ((0, "aa"), (30_000, "ab"), (60_000, "ac")):
            self.write(STANDARD_PART.format(suffix), b"".join(lines[start:start + 30_000]))
        result = self.run_validator()
        self.assertEqual(result.returncode, 0, result.stderr)
        (self.root / STANDARD_PART.format("ab")).unlink()
        self.assert_rejected()

    def test_parts_must_be_the_exact_source_bytes(self):
        for raw in (b"", b"1.1.1.1\n", b"1.1.1.1\n9.9.9.9\n", SAMPLE + b"8.8.8.8\n",
                    SAMPLE.replace(b"\n", b"\r\n"), SAMPLE[::-1]):
            with self.subTest(raw=raw):
                self.write(STANDARD_PART.format("aa"), raw)
                self.assert_rejected()

    def test_reject_nonregular_files(self):
        target = self.root / STANDARD_PART.format("aa")
        target.unlink()
        target.symlink_to(self.root / STANDARD)
        self.assert_rejected()
        target.unlink()
        os.mkfifo(target)
        self.assert_rejected()

    def test_git_head_checks_the_actual_published_blobs_and_file_set(self):
        self.git("init", "--quiet")
        self.git("add", "--", *[p.name for p in self.root.glob("*.txt")])
        self.git("commit", "--quiet", "-m", "Test canonical feeds")
        result = self.run_validator("--git-head")
        self.assertEqual(result.returncode, 0, result.stderr)
        for name in (STANDARD, STANDARD_PART.format("aa")):
            self.write(name, b"8.8.4.4\n")
        self.assert_rejected("--git-head")
        for name in (STANDARD, STANDARD_PART.format("aa")):
            self.write(name, SAMPLE)
        extra = STANDARD_PART.format("ab")
        self.write(extra, SAMPLE)
        self.git("add", "--", extra)
        self.git("commit", "--quiet", "-m", "Test a stale committed part")
        (self.root / extra).unlink()
        self.assert_rejected("--git-head")


if __name__ == "__main__":
    unittest.main()
