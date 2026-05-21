#!/usr/bin/env bash
#
# Purpose: Validate IPv4/CIDR formats, deduplicate, and generate SHA256 hashes.
# Standard: Hardened and universal (Ubuntu, Debian, CentOS, AlmaLinux, Rocky Linux, RHEL).

set -euo pipefail

# Enable nullglob so empty matches yield empty arrays
shopt -s nullglob

readonly HASH_FILE="sha256sums.txt"
readonly TARGET_FILES=(prod_*data-shield_ipv4_blocklist.txt)

# Initialize or clear the hash file safely
>"$HASH_FILE"

echo "[INFO] Starting CIA Integrity Workflow..."

if [[ ${#TARGET_FILES[@]} -eq 0 ]]; then
    echo "[WARN] No target files found matching pattern."
    exit 0
fi

for file in "${TARGET_FILES[@]}"; do
    echo "[INFO] Validating and sanitizing: $file"

    # 1. Sanitize, validate IPv4/CIDR, sort, and deduplicate in a single efficient awk/sort pass
    # The awk regex checks for standard IPv4 formats and optional CIDR (/0 to /32)
    if ! awk '
        /^[[:space:]]*#/ || /^[[:space:]]*$/ { next }
        {
            # Strip leading and trailing whitespace
            gsub(/^[[:space:]]+|[[:space:]]+$/, "")
            
            # Strict regex for valid IPv4 and optional CIDR
            if (match($0, /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)((\/([0-9]|[1-2][0-9]|3[0-2]))?)$/)) {
                print $0
            } else {
                print "[ERROR] Invalid entry or injection detected: " $0 > "/dev/stderr"
                exit 1
            }
        }
    ' "$file" | sort -u -V >"${file}.tmp"; then
        echo "[FATAL] Integrity check failed on $file. Pipeline stopped." >&2
        rm -f "${file}.tmp"
        exit 1
    fi

    # Replace original file with validated, sorted, and unique content
    mv "${file}.tmp" "$file"

    # 2. Generate SHA256 checksum for integrity proof
    sha256sum "$file" >>"$HASH_FILE"
done

echo "[INFO] Integrity check complete. Generated artifacts:"
cat "$HASH_FILE"
