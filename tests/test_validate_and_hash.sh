#!/usr/bin/env bash
# Run the validator's regression suite in isolated temporary directories.
set -euo pipefail
exec python3 -I "$(dirname -- "$0")/test_validate_and_hash.py"
