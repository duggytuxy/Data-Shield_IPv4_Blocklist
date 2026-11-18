# How to contribute?

## Validate changes to the integrity checks

Run the following commands from the repository root on Linux with Bash, Python 3 and Git.

```sh
bash tests/test_validate_and_hash.sh
bash .github/scripts/validate_and_hash.sh --git-head
sha256sum -c sha256sums.txt
```

The validator checks the two complete profiles and verifies each part against its consecutive rows in the corresponding profile. CI also checks every digest against the raw Git blob at `HEAD` before uploading the checksum artifact. For local feed edits, omit `--git-head` to check the working files.

## ️ By supporting Data-Shield IPv4 Blocklist!

Data-Shield IPv4 Blocklist requires time and funding. That is why it is important to appeal for donations so that it can be maintained over time and in the best possible conditions:

- **Ko-Fi**: ```https://ko-fi.com/laurentmduggytuxy```

---

