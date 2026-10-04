# UniFi Gateway Integration

UniFi Gateways support dynamic IPv4 Network Lists fetched from a URL and refreshed automatically. This guide uses the main Data-Shield production list to block incoming traffic from listed IPv4 addresses, both to the gateway itself and to public-facing services.

## Requirements

- A UniFi Gateway running **UniFi OS 6.0.10 or newer**.
- **UniFi Network Application 11.0.81 or newer**.
- Zone-Based Firewall enabled, with the networks hosting your public-facing services assigned to the appropriate destination zones.

## 1. Create the dynamic Network List

1. Sign in to your UniFi Gateway and open the **Network** application.
2. Go to **Settings > Networks**, scroll to **Network Lists**, and click **Create New**.
3. Give the list a recognizable name, such as **Data-Shield-IPv4**.
4. Set **Type** to **IPv4** and **Source** to **Dynamic**.
5. Paste the following raw URL into **URL**:

   ```text
   https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt
   ```

6. Set **Update Interval** to **24 Hours**. UniFi offers **24, 48, or 72 hours**; 24 hours is the shortest available interval. Data-Shield publishes updates every 6 hours, so the gateway will fetch the list daily rather than after every feed update.
7. Click **Update Now** and check that IPv4 addresses appear in the preview. Click **Add** to save the list.

The list is now available for use in firewall policies. Creating the list alone does not block traffic.

> **Capacity:** UniFi supports up to **100,000 entries per dynamic list**. If the main list grows beyond this limit, UniFi truncates the excess entries and displays a warning. The imported entries remain available for filtering, but coverage is limited to the first 100,000 entries.

## 2. Protect the gateway: External to Gateway

1. Go to **Settings > Policy Engine > Zones**.
2. In the **Zone Matrix**, click the cell at source row **External** and destination column **Gateway**.
3. Create a new policy with the following settings:

   | Setting | Value |
   | :--- | :--- |
   | Name | `Block-Data-Shield-Gateway` |
   | Source Zone | **External** |
   | Source selector | **IP > List > Data-Shield-IPv4** |
   | Source Port | **Any** |
   | Action | **Block** |
   | Destination Zone | **Gateway** |
   | Destination selector | **Any** |
   | Destination Port | **Any** |

4. Set the policy to match **IPv4** traffic across all protocols and keep it active continuously.
5. Click **Add Policy**.
6. Check its position in the policy table. Use **Reorder** to place it before any allow policy that could otherwise accept matching incoming traffic.

This policy blocks traffic from listed sources that is addressed to the UniFi Gateway itself.

## 3. Protect published services: External to DMZ

Create a second policy from the **External** row to the **DMZ** column of the Zone Matrix. Use the same source list, ports, action, and IPv4 settings as above, with these changes:

| Setting | Value |
| :--- | :--- |
| Name | `Block-Data-Shield-DMZ` |
| Destination Zone | **DMZ** |

Click **Add Policy** and place the block policy before allow policies for the published services, including those created for port forwarding.

> **Why both policies are needed:** **Gateway** covers traffic addressed to the gateway itself. Traffic forwarded to a service, such as a reverse proxy hosted in the DMZ, has **DMZ** as its destination zone. An **External > Gateway** policy does not match that traffic.

Check the zone assigned to the network hosting each published service. If a service is in **Internal** or a custom zone, create the corresponding **External > destination zone** block policy there as well.

Keep the source zone set to **External** for these policies, following the project's [inbound deployment strategy](../README.md#deployment-strategy).

## 4. Verify the configuration

- Open the Network List and check its loaded entries, **Last Updated** value, and any capacity or download warnings. Use **Update Now** to request a manual refresh.
- Confirm that each block policy uses **Data-Shield-IPv4** as its source list and targets the intended destination zone.
- Check policy ordering, especially before port-forwarding allow policies.
- Optionally enable logging on the block policies to confirm matching incoming traffic is dropped. A populated list confirms retrieval; firewall logs provide evidence that the policies are matching traffic.

For more information about zone assignments, firewall policies, and rule ordering, see Ubiquiti's [Zone-Based Firewalls in UniFi](https://help.ui.com/hc/en-us/articles/115003173168-Zone-Based-Firewalls-in-UniFi).
