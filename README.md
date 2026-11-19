<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/data-shield-hero-dark.svg">
    <img src="assets/data-shield-hero-light.svg" alt="Data-Shield IPv4 Blocklists: a shield with a centered D and four IPv4 nodes" width="100%">
  </picture>
</div>

<br>

<div align="center">
  <a href="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/actions/workflows/cia-integrity.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/duggytuxy/Data-Shield_IPv4_Blocklist/cia-integrity.yml?branch=main&amp;style=flat-square&amp;logo=githubactions&amp;logoColor=white&amp;label=Integrity" alt="Blocklist integrity workflow status">
  </a>
  <a href="#format-and-updates">
    <img src="https://img.shields.io/badge/Scheduled-every%202%20hours-006b61?style=flat-square" alt="Generation scheduled every two hours">
  </a>
  <a href="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/commits/main/">
    <img src="https://img.shields.io/github/last-commit/duggytuxy/Data-Shield_IPv4_Blocklist?style=flat-square&amp;logo=github&amp;logoColor=white&amp;label=Repository%20commit&amp;color=122936" alt="Latest repository commit">
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-GPLv3-006b61?style=flat-square&amp;logo=gnu&amp;logoColor=white" alt="GNU GPLv3 license">
  </a>
  <a href="https://github.com/duggytuxy/syswarden">
    <img src="https://img.shields.io/badge/SYSwarden-Linux%20defense-122936?style=flat-square" alt="Explore SYSwarden Linux defense">
  </a>
  <a href="https://ko-fi.com/laurentmduggytuxy">
    <img src="https://img.shields.io/badge/Ko--fi-Support-ff5e5b?style=flat-square&amp;logo=kofi&amp;logoColor=white" alt="Support Data-Shield on Ko-fi">
  </a>
</div>

# Data-Shield IPv4 Blocklists

**Community Standard is free. Data-Shield Pro supports the project and includes Critical.**

Data-Shield provides maintained IPv4 blocklists for inbound filtering on firewalls, gateways and web application firewalls. Choose the policy that fits your environment, use the access method below, and review its effect on legitimate traffic.

[Get free Standard](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt) · [Compare Standard and Pro](#choose-your-list) · [Set up Pro access](#data-shield-pro-access) · [Open subscriber portal](https://feeds.data-shield.eu/) · [Report a false positive](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/issues/new/choose)

## Choose your list

| | Community Standard | Data-Shield Pro |
| :--- | :--- | :--- |
| **Inbound filtering** | A starting point for Internet-facing services, with reviewed exceptions. | Critical includes Standard coverage and additional blocked sources for stricter inbound filtering. Both profiles apply the shared whitelist. |
| **Access and price** | Free through public downloads and mirrors. No account required. | €50 per month or €500 per year via recurring PayPal subscription. The subscription supports project maintenance. |
| **Feed format** | Complete IPv4 TXT file and all splits, up to 30,000 addresses per part. | Same format and split size. Both billing options include the complete Critical file and all its splits. |
| **Updates and verification** | Public files, commit history and SHA-256 checksums. | An authenticated manifest identifies one generation and gives the URL, count, byte size and SHA-256 for every file. |

Choose Critical when additional blocking coverage is worth the higher risk of blocking legitimate traffic. Start in a monitored policy and review matches for your services before broad enforcement. One complete profile covers your chosen policy.

The entry count changes over time. Check your product's capacity against the actual file, including whether it silently truncates oversized imports. There is no fixed 100,000-entry cap.

## Split feeds

For devices with per-list entry limits, import every part of one profile as a separate feed and include them all in the same inbound policy. Each part contains up to 30,000 addresses. The public publisher commits the complete Standard file and all its parts together. Concatenating its parts in suffix order reproduces the complete Standard file from that commit. Subscribers receive the complete Critical feed and its matching parts through the private portal.

| Part | Standard |
| :--- | :--- |
| aa | [Raw Standard aa](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/main/prod_aa-data-shield_ipv4_blocklist.txt) |
| ab | [Raw Standard ab](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/main/prod_ab-data-shield_ipv4_blocklist.txt) |
| ac | [Raw Standard ac](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/main/prod_ac-data-shield_ipv4_blocklist.txt) |
| ad | [Raw Standard ad](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/main/prod_ad-data-shield_ipv4_blocklist.txt) |

If a Critical generation needs an extra part, it is included in the existing subscription at no extra charge. Data-Shield does not send an email when a part appears. Read the manifest at each refresh and load every part it lists. On a firewall configured with fixed split URLs, add the new part to the same inbound policy. If the complete file fits the device, a single full-feed URL follows future growth.

The table covers the first four Standard parts. Check the [Standard downloads](https://data-shield.eu/#split-downloads) for the current set before configuring your firewall.

## Stable download URLs

| Destination | Standard |
| :--- | :--- |
| **[GitHub](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist)** | [Raw file](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt) |
| **[GitLab](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist)** | [Raw file](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_data-shield_ipv4_blocklist.txt?ref_type=heads) |
| **[Codeberg](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist)** | [Raw file](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_data-shield_ipv4_blocklist.txt) |
| **[Bitbucket](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/src/main/)** | [Raw file](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/HEAD/prod_data-shield_ipv4_blocklist.txt) |
| **[jsDelivr CDN](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@main/)** | [Raw file](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_data-shield_ipv4_blocklist.txt) |

These public URLs distribute the complete Community Standard list. GitLab manages repository mirroring to Codeberg and Bitbucket. jsDelivr serves a cached copy from GitHub, so CDN refreshes can lag behind publication.

Use a raw file URL in your firewall's feed configuration. A repository or preview-page URL returns a web page, not the blocklist.

## Format and updates

- Plain text, with one public IPv4 address per line.
- No headers, comments, ports, CIDR ranges or IPv6 entries.
- Duplicate addresses removed and addresses sorted numerically.
- Generation scheduled **every two hours**. A new commit appears only when published file content changes.
- The complete Standard file and all its parts are validated before publication on GitHub and GitLab. Downstream mirrors and CDN caches can differ until they refresh.
- Failed generation checks preserve the last validated files. Failed publication is retried independently.

The public repository distributes Community Standard and its usage documentation. Review a file's commit history to check when its content last changed. Neither a successful download nor an unchanged commit proves that your firewall has applied the latest available data.

## Deployment strategy

1. **Start with the standard profile.** Check the number of entries and your device's import limits.
2. **Apply the list to inbound Internet traffic.** Match the remote source address on traffic reaching the gateway or your published services. Do not apply the feed as a blanket outbound destination blocklist.
3. **Review rule ordering and local exceptions.** Preserve required administration and business access. A whitelist must take precedence according to your firewall's own rule model.
4. **Observe before broad enforcement.** Use logging or a limited deployment to inspect matches and identify legitimate services that need exceptions.
5. **Refresh and monitor.** Configure automatic retrieval where supported. Check fetch failures, truncation warnings and the number of entries actually loaded. Keep the last working rules if a download or import fails.

### Platform integration guides

The [Data-Shield website documentation](https://data-shield.eu/docs/) provides setup instructions, copyable feed URLs and commands, capacity checks, and verification steps for sixteen platforms:

| Platform | Integration method |
| :--- | :--- |
| **[FortiOS / FortiGate](https://data-shield.eu/docs/fortios/)** | Native HTTPS IP address external feed. |
| **[UniFi](https://data-shield.eu/docs/unifi/)** | Dynamic IPv4 Network List with zone-based firewall policies. |
| **[Palo Alto / PAN-OS](https://data-shield.eu/docs/palo-alto/)** | IP External Dynamic List with certificate validation. |
| **[OPNsense](https://data-shield.eu/docs/opnsense/)** | Regularly refreshed URL table alias. |
| **[pfSense CE / Plus](https://data-shield.eu/docs/pfsense/)** | Native URL Table (IPs), with daily refresh and capacity checks. |
| **[Sophos Firewall](https://data-shield.eu/docs/sophos/)** | SFOS 22.0 third-party threat feeds, with entitlement and polling checks. |
| **[VyOS](https://data-shield.eu/docs/vyos/)** | Native remote groups, with release-specific refresh settings. |
| **[MikroTik RouterOS](https://data-shield.eu/docs/routeros/)** | RouterOS v7 with a Linux controller for verified complete-feed updates. |
| **[OpenWrt](https://data-shield.eu/docs/openwrt/)** | OpenWrt 25.12 with native banIP feeds and scheduled two-hour reloads. |
| **[Stormshield / SNS](https://data-shield.eu/docs/stormshield/)** | Validated CSV conversion and manual custom web services import. |
| **[IPFire](https://data-shield.eu/docs/ipfire/)** | Locally maintained source definitions with native two-hour update eligibility and Core Update persistence checks. |
| **[F5 BIG-IP / AFM](https://data-shield.eu/docs/f5-big-ip/)** | AFM custom IP Intelligence feeds with two-hour HTTPS polling and scoped source-address enforcement. |
| **[OpenCTI](https://data-shield.eu/docs/opencti/)** | Headerless CSV feeds for IPv4 observables, with hourly ingestion and explicit provenance. |
| **[MISP](https://data-shield.eu/docs/misp/)** | Freetext feed caches for attribute correlation, refreshed by dedicated two-hour jobs. |
| **[CrowdSec](https://data-shield.eu/docs/crowdsec/)** | Verified two-hour LAPI imports with three-hour ban decisions, local allowlists and bouncer enforcement checks. |
| **[nftables](https://data-shield.eu/docs/nftables/)** | Verified atomic replacement of dedicated IPv4 sets, with two-hour refresh and persistent last-successful state. |

OpenCTI and MISP provide investigation workflows. Raw IP feeds do not automatically import CVE associations or establish successful exploitation; the guides explain how to preserve dated evidence and verify current membership.

The [UniFi guide in this repository](docs/unifi.md) also remains available. Check the guide for your release and appliance model. Product refresh intervals can be longer than Data-Shield's generation interval; the Stormshield workflow requires a manual import.

IP-based blocking is one layer of protection. It complements application security, patching, authentication, rate limiting and monitoring. It cannot identify every attack, and shared or reassigned addresses can produce false positives.

## False positives and corrections

[Open a false-positive report](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/issues/new/choose) with:

- The affected IPv4 address and the list you use.
- The legitimate service affected and the time of the observed block.
- A concise explanation and sanitized evidence that helps reproduce the issue.

Do not post credentials, private logs or personal information in a public issue. For sensitive evidence or security vulnerabilities, follow the [security policy](SECURITY.md). If access must be restored immediately, apply a narrowly scoped local exception while the report is reviewed.

## Data-Shield Pro access

1. **Choose a subscription.** Open the [subscriber portal](https://feeds.data-shield.eu/) and choose **€50 per month** or **€500 per year**. Both recurring PayPal plans include the same Critical feed and support community maintenance.
2. **Approve and confirm.** Approve the subscription in PayPal and return to Data-Shield. The portal verifies the payment. If it shows **Confirming your payment**, use **Check payment status again** on the existing order. After confirmation, the browser opens the [integration guide](https://data-shield.eu/docs/#subscriber-setup).
3. **Collect your device credential.** Reopen the portal in the same browser used for checkout and claim your token promptly. The checkout browser session lasts 24 hours from when it starts. Choose **Check payment and issue or replace device token**, then **Show device credential**. Save the **Device ID** and **Bearer token** in a password manager. Issuing a replacement invalidates the previous token issued through this browser. **Verify my feed downloads** checks that this device can fetch the feed.
4. **Connect a device.** Authenticate over HTTPS with the token in the `Authorization: Bearer <device-token>` header. For devices supporting HTTP Basic, use the Device ID as username and the token as password. For appliances that accept only a URL, use a relay on your own network that authenticates upstream and allows access only from your appliance. Keep credentials out of feed URLs, logs and public tickets.
5. **Choose full or split and verify.** Fetch the private manifest. Its first entry is the complete feed. The remaining entries are its splits in order. Use the complete file if it fits, or import every split into the same inbound policy. Use URLs from one manifest generation. Verify byte sizes, record counts and SHA-256 before switching. Concatenating the parts in order reproduces the complete file byte for byte.
6. **Migrate and monitor.** Replace previous public Critical URLs with authenticated downloads. Configure a refresh schedule appropriate for your appliance. Monitor the last successful generation and imported count, and retain the previous validated rules if a refresh fails. Standard and its splits keep their public URLs.

### Test the private manifest

With curl, replace `YOUR_DEVICE_ID` below with the ID shown by the portal. At curl's password prompt, enter the device token. This keeps the token out of the URL and shell history.

```sh
curl --fail --silent --show-error --proto '=https' \
  --user 'YOUR_DEVICE_ID' \
  --output critical-manifest.json \
  https://feeds.data-shield.eu/feeds/critical/manifest.json
```

The JSON contains `generation` and an ordered `files` array. Each `url` is a versioned path on `https://feeds.data-shield.eu` and requires the same device authentication. A scheduled appliance download needs a stable URL so it can move to newer generations. For each desired file, append its `name` to `https://feeds.data-shield.eu/feeds/critical/`. To refresh several parts together, fetch a fresh manifest each time and use its versioned URLs. See the [subscriber integration guide](https://data-shield.eu/docs/#subscriber-setup) for setup and platform instructions.

## Project and support

Maintained by **Laurent Minne / Duggy Tuxy**. You can support the project's maintenance with an [optional donation on Ko-fi](https://ko-fi.com/laurentmduggytuxy). Donations are separate from Pro subscriptions.

For Linux host protection, explore [SYSwarden](https://syswarden.io) and its [repository](https://github.com/duggytuxy/syswarden).

See [contributing](CONTRIBUTING.md), the [code of conduct](CODE_OF_CONDUCT.md), and the [GNU GPLv3 license](LICENSE).

Copyright 2023-2026 Laurent Minne / Duggy Tuxy.
