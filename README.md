# Data-Shield IPv4 Blocklists

**Two complete lists. Clear choices. Controlled updates.**

Data-Shield provides maintained IPv4 blocklists for inbound filtering on firewalls, gateways and web application firewalls. Choose the policy that fits your environment, import its raw URL, and review its effect on legitimate traffic.

[Download standard](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt) · [Download critical](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_critical_data-shield_ipv4_blocklist.txt) · [Report a false positive](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/issues/new/choose)

## Choose your list

| Profile | Intended use | File |
| :--- | :--- | :--- |
| **Standard** | The starting point for Internet-facing services, with reviewed exceptions to reduce avoidable blocking. | [`prod_data-shield_ipv4_blocklist.txt`](prod_data-shield_ipv4_blocklist.txt) |
| **Critical** | A broader blocking policy for environments that accept stricter ingress filtering. Review the impact before deployment. | [`prod_critical_data-shield_ipv4_blocklist.txt`](prod_critical_data-shield_ipv4_blocklist.txt) |

Each file is complete and can be used on its own. Applying both lists combines their blocking decisions and may override the exceptions of the profile you intended to use.

The entry count changes over time. Check your product's capacity against the actual file, including whether it silently truncates oversized imports. There is no fixed 100,000-entry cap. Split files are no longer published; existing integrations must use one of the two complete files above.

## Stable download URLs

| Destination | Standard | Critical |
| :--- | :--- | :--- |
| **GitHub** | [Raw file](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt) | [Raw file](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_critical_data-shield_ipv4_blocklist.txt) |
| **GitLab** | [Raw file](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_data-shield_ipv4_blocklist.txt) | [Raw file](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_critical_data-shield_ipv4_blocklist.txt) |

Use a raw file URL in your firewall's feed configuration. A repository or preview-page URL returns a web page, not the blocklist.

## Format and updates

- Plain text, with one public IPv4 address per line.
- No headers, comments, ports, CIDR ranges or IPv6 entries.
- Duplicate addresses removed and addresses sorted numerically.
- Generation scheduled **every two hours**. A new commit appears only when published file content changes.
- Both files validated before publication and committed together within each destination. Mirrors may briefly differ while publication completes.
- Failed generation checks preserve the last validated files. Failed publication is retried independently.

The public repository distributes the lists and their usage documentation. Review a file's commit history to check when its content last changed. Neither a successful download nor an unchanged commit proves that your firewall has applied the latest available data.

## Deployment strategy

1. **Start with the standard profile.** Check the number of entries and your device's import limits.
2. **Apply the list to inbound Internet traffic.** Match the remote source address on traffic reaching the gateway or your published services. Do not apply the feed as a blanket outbound destination blocklist.
3. **Review rule ordering and local exceptions.** Preserve required administration and business access. A whitelist must take precedence according to your firewall's own rule model.
4. **Observe before broad enforcement.** Use logging or a limited deployment to inspect matches and identify legitimate services that need exceptions.
5. **Refresh and monitor.** Configure automatic retrieval where supported. Check fetch failures, truncation warnings and the number of entries actually loaded. Keep the last working rules if a download or import fails.

For UniFi gateways, see the [integration guide](docs/unifi.md). Product refresh intervals can be longer than Data-Shield's generation interval.

IP-based blocking is one layer of protection. It complements application security, patching, authentication, rate limiting and monitoring. It cannot identify every attack, and shared or reassigned addresses can produce false positives.

## False positives and corrections

[Open a false-positive report](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/issues/new/choose) with:

- The affected IPv4 address and the list you use.
- The legitimate service affected and the time of the observed block.
- A concise explanation and sanitized evidence that helps reproduce the issue.

Do not post credentials, private logs or personal information in a public issue. For sensitive evidence or security vulnerabilities, follow the [security policy](SECURITY.md). If access must be restored immediately, apply a narrowly scoped local exception while the report is reviewed.

## Project and support

Maintained by **Laurent Minne / Duggy Tuxy**. If these lists help protect your services, you can [support their maintenance on Ko-fi](https://ko-fi.com/laurentmduggytuxy).

For Linux host protection, explore [SysWarden](https://syswarden.io) and its [repository](https://github.com/duggytuxy/syswarden).

See [contributing](CONTRIBUTING.md), the [code of conduct](CODE_OF_CONDUCT.md), and the [GNU GPLv3 license](LICENSE).

Copyright 2023-2026 Laurent Minne / Duggy Tuxy.
