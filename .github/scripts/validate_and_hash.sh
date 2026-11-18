#!/usr/bin/env bash
# Validate the feeds in the current directory with Python 3's standard library.
set -euo pipefail
exec python3 -I "$(dirname -- "$0")/validate_and_hash.py" "$@"
