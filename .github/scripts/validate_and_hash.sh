#!/usr/bin/env bash
#
# Purpose: Validate IPv4 formats, deduplicate, sort, and generate SHA256 hashes.
# Standard: Bash + GNU coreutils (Ubuntu, Debian, CentOS, AlmaLinux, Rocky Linux, RHEL).

set -euo pipefail

# Enable nullglob so unmatched patterns produce an empty array.
shopt -s nullglob

readonly HASH_FILE="sha256sums.txt"
readonly TARGET_FILES=(prod_*data-shield_ipv4_blocklist.txt)

# Create a temporary directory in the current directory.
# This keeps staged files on the same filesystem as the originals.
TEMP_DIR="$(mktemp -d "./.cia-integrity.XXXXXX")"

cleanup() {
    rm -rf -- "$TEMP_DIR"
}
trap cleanup EXIT

echo "[INFO] Starting CIA Integrity Workflow..."

if [[ ${#TARGET_FILES[@]} -eq 0 ]]; then
    echo "[WARN] No target files found matching pattern."
    exit 0
fi

# Stage and validate every file before modifying any original file.
for file in "${TARGET_FILES[@]}"; do
    echo "[INFO] Validating: $file"

    STAGED_FILE="$TEMP_DIR/$file"

    if ! awk '
        {
            # Remove leading and trailing whitespace.
            gsub(/^[[:space:]]+|[[:space:]]+$/, "")

            # Reject blank lines.
            if ($0 == "") {
                print "[ERROR] Blank line detected." > "/dev/stderr"
                exit 1
            }

            # Accept individual IPv4 addresses only.
            # Reject CIDR, IPv6, hostnames, and malformed addresses.
            if ($0 ~ /^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$/) {
                print $0
            } else {
                print "[ERROR] Invalid IPv4 entry: " $0 > "/dev/stderr"
                exit 1
            }
        }

        # Reject completely empty files.
        END {
            if (NR == 0) {
                print "[ERROR] Empty blocklist file." > "/dev/stderr"
                exit 1
            }
        }
    ' "$file" | sort -u -V > "$STAGED_FILE"; then
        echo "[FATAL] Validation failed for $file." >&2
        echo "[INFO] Original files and existing checksum file were not updated." >&2
        exit 1
    fi

    # Preserve original file permissions after the staged file is created.
    chmod --reference="$file" "$STAGED_FILE"

    echo "[PASS] Validation successful: $file"
done

# Generate checksums from all validated staged files.
# The existing checksum file remains untouched until validation succeeds.
(
    cd "$TEMP_DIR"
    sha256sum -- "${TARGET_FILES[@]}"
) > "$TEMP_DIR/$HASH_FILE"

# All files passed validation. Replace the original blocklists.
echo "[INFO] All files validated. Updating blocklists..."

for file in "${TARGET_FILES[@]}"; do
    mv -f -- "$TEMP_DIR/$file" "$file"
    echo "[PASS] Updated: $file"
done

# Update the checksum file after successful blocklist replacement.
mv -f -- "$TEMP_DIR/$HASH_FILE" "$HASH_FILE"

echo
echo "[INFO] Integrity check complete."
echo "[INFO] Generated SHA256 checksums:"
cat "$HASH_FILE"
