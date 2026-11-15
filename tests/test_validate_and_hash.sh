#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
VALIDATOR="$ROOT_DIR/.github/scripts/validate_and_hash.sh"
where.exe dirname
where.exe mktemp

TEMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TEMP_DIR"' EXIT

PASS=0
FAIL=0

# Print and record test results.
pass() {
    echo "[PASS] $1"
    ((PASS+=1))
}

fail() {
    echo "[FAIL] $1"
    ((FAIL+=1))
}

# Create an isolated test directory.
new_case() {
    CASE_DIR="$TEMP_DIR/$1"
    mkdir -p "$CASE_DIR"
}

# Run the validator inside the test directory.
run_validator() {
    local status=0

    (
        cd "$CASE_DIR"
        bash "$VALIDATOR"
    ) >"$CASE_DIR/output.log" 2>&1 || status=$?

    return "$status"
}

echo "======================================"
echo " Running IPv4 Validator Test Suite"
echo "======================================"

# 1. Valid IPv4 address.
new_case "valid-ipv4"
printf '%s\n' "192.168.1.1" > "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"

if run_validator; then
    pass "Accept valid IPv4 address"
else
    fail "Accept valid IPv4 address"
fi

# 2. Valid public IPv4 address.
new_case "valid-public-ipv4"
printf '%s\n' "8.8.8.8" > "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"

if run_validator; then
    pass "Accept valid public IPv4 address"
else
    fail "Accept valid public IPv4 address"
fi

# 3. Reject invalid octet.
new_case "invalid-octet"
printf '%s\n' "256.1.1.1" > "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"

if run_validator; then
    fail "Reject IPv4 octet above 255"
else
    pass "Reject IPv4 octet above 255"
fi

# 4. Reject incomplete IPv4.
new_case "invalid-format"
printf '%s\n' "192.168.1" > "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"

if run_validator; then
    fail "Reject incomplete IPv4 address"
else
    pass "Reject incomplete IPv4 address"
fi

# 5. Reject CIDR notation.
new_case "cidr"
printf '%s\n' "192.168.1.1/24" > "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"

if run_validator; then
    fail "Reject CIDR notation"
else
    pass "Reject CIDR notation"
fi

# 6. Reject IPv6.
new_case "ipv6"
printf '%s\n' "2001:db8::1" > "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"

if run_validator; then
    fail "Reject IPv6 address"
else
    pass "Reject IPv6 address"
fi

# 7. Reject hostnames.
new_case "hostname"
printf '%s\n' "example.com" > "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"

if run_validator; then
    fail "Reject hostname"
else
    pass "Reject hostname"
fi

# 8. Reject malformed input.
new_case "malformed"
printf '%s\n' "hello-world" > "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"

if run_validator; then
    fail "Reject malformed input"
else
    pass "Reject malformed input"
fi

# 9. Reject an empty blocklist.
new_case "empty-file"
: > "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"

if run_validator; then
    fail "Reject empty blocklist"
else
    pass "Reject empty blocklist"
fi

# 10. Reject blank lines.
new_case "blank-line"
printf '192.168.1.1\n\n8.8.8.8\n' > "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"

if run_validator; then
    fail "Reject blank lines"
else
    pass "Reject blank lines"
fi

# 11. Remove duplicate IPv4 addresses.
new_case "duplicates"
printf '8.8.8.8\n1.1.1.1\n8.8.8.8\n' > "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"

if run_validator; then
    expected="$CASE_DIR/expected.txt"
    printf '1.1.1.1\n8.8.8.8\n' > "$expected"

    if cmp -s "$expected" "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"; then
        pass "Remove duplicate IPv4 addresses"
    else
        fail "Remove duplicate IPv4 addresses"
    fi
else
    fail "Remove duplicate IPv4 addresses"
fi

# 12. Sort IPv4 addresses numerically.
new_case "sorting"
printf '192.168.1.10\n10.0.0.2\n10.0.0.10\n' > "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"

if run_validator; then
    expected="$CASE_DIR/expected.txt"
    printf '10.0.0.2\n10.0.0.10\n192.168.1.10\n' > "$expected"

    if cmp -s "$expected" "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"; then
        pass "Sort IPv4 addresses numerically"
    else
        fail "Sort IPv4 addresses numerically"
    fi
else
    fail "Sort IPv4 addresses numerically"
fi

# 13. Verify SHA256 checksum generation.
new_case "checksum"
printf '%s\n' "8.8.8.8" > "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"

if run_validator; then
    if (
        cd "$CASE_DIR"
        sha256sum -c sha256sums.txt >/dev/null 2>&1
    ); then
        pass "Generate valid SHA256 checksum"
    else
        fail "Generate valid SHA256 checksum"
    fi
else
    fail "Generate valid SHA256 checksum"
fi

# 14. Preserve original file permissions.
new_case "permissions"
printf '%s\n' "8.8.8.8" > "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"
chmod 640 "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt"

# Record the permissions actually supported by the current system.
expected_permissions="$(stat -c '%a' "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt")"

if run_validator; then
    actual_permissions="$(stat -c '%a' "$CASE_DIR/prod_test_data-shield_ipv4_blocklist.txt")"

    if [[ "$actual_permissions" == "$expected_permissions" ]]; then
        pass "Preserve original file permissions"
    else
        fail "Preserve original file permissions (expected $expected_permissions, got $actual_permissions)"
    fi
else
    fail "Preserve original file permissions"
fi

# 15. Ensure validation failure leaves original files and checksums unchanged.
new_case "failure-safety"

printf '8.8.8.8\n' > "$CASE_DIR/prod_a_data-shield_ipv4_blocklist.txt"
printf '256.1.1.1\n' > "$CASE_DIR/prod_b_data-shield_ipv4_blocklist.txt"
printf 'existing-checksum-data\n' > "$CASE_DIR/sha256sums.txt"

if run_validator; then
    fail "Preserve original files after validation failure"
else
    if [[ "$(cat "$CASE_DIR/prod_a_data-shield_ipv4_blocklist.txt")" == "8.8.8.8" ]] &&
       [[ "$(cat "$CASE_DIR/prod_b_data-shield_ipv4_blocklist.txt")" == "256.1.1.1" ]] &&
       [[ "$(cat "$CASE_DIR/sha256sums.txt")" == "existing-checksum-data" ]]; then
        pass "Preserve original files after validation failure"
    else
        fail "Preserve original files after validation failure"
    fi
fi

echo
echo "======================================"
echo " Test Results"
echo "======================================"
echo "Passed: $PASS"
echo "Failed: $FAIL"
echo "Total:  $((PASS + FAIL))"

if [[ "$FAIL" -gt 0 ]]; then
    exit 1
fi

echo
echo "All tests passed successfully!"
