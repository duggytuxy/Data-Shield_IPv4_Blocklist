Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Variables
$BlocklistUrl = "https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
$BlocklistDir = "C:\FirewallBlocklist"
$PreviousBlocklist = Join-Path $BlocklistDir "previous_blocklist.txt"
$CurrentBlocklist = Join-Path $BlocklistDir "current_blocklist.txt"
$TmpBlocklist = Join-Path $BlocklistDir "tmp_blocklist.txt"
$LogFile = "C:\FirewallBlocklist\firewall_update.log"
$RulePrefix = "DynamicBlocklist"

function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $LogFile -Value "$timestamp : $Message"
}

# Preparation
if (!(Test-Path $BlocklistDir)) { New-Item -ItemType Directory -Path $BlocklistDir | Out-Null }
if (!(Test-Path $PreviousBlocklist)) { New-Item -ItemType File -Path $PreviousBlocklist | Out-Null }
if (!(Test-Path $LogFile)) { New-Item -ItemType File -Path $LogFile | Out-Null }

# Download blocklist
try {
    Invoke-WebRequest -Uri $BlocklistUrl -OutFile $TmpBlocklist -UseBasicParsing
} catch {
    Write-Log "ERROR: Failed to download blocklist from $BlocklistUrl"
    exit 1
}

# Validate IPs
$NewIPs = Get-Content $TmpBlocklist | Where-Object { $_ -match '^(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)\.(25[0-5]|2[0-4]\d|[01]?\d\d?)$' } | Sort-Object -Unique
$NewIPs | Set-Content $CurrentBlocklist
$OldIPs = @(Get-Content $PreviousBlocklist)

# Remove old rules
Get-NetFirewallRule | Where-Object { $_.DisplayName -like "$RulePrefix*" } | Remove-NetFirewallRule

# Add new rules in chunks (max 1000 IPs per rule)
$ChunkSize = 1000
for ($i = 0; $i -lt $NewIPs.Count; $i += $ChunkSize) {
    $Chunk = $NewIPs[$i..([Math]::Min($i + $ChunkSize - 1, $NewIPs.Count - 1))]
    $RemoteAddresses = $Chunk -join ","
    $RuleName = "$RulePrefix-$([int]($i / $ChunkSize) + 1)"
    try {
        New-NetFirewallRule -DisplayName $RuleName -Direction Inbound -Action Block -RemoteAddress $RemoteAddresses
        Write-Log "INFO: Added firewall rule $RuleName with $($Chunk.Count) IPs"
    } catch {
        Write-Log "ERROR: Failed to add rule $RuleName. Reason: $($_.Exception.Message)"
    }
}

# Log changes
Compare-Object $OldIPs $NewIPs | ForEach-Object {
    if ($_.SideIndicator -eq "=>") { Write-Log "ADDED: $($_.InputObject)" }
    elseif ($_.SideIndicator -eq "<=") { Write-Log "REMOVED: $($_.InputObject)" }
}

# Save current blocklist
Copy-Item $CurrentBlocklist $PreviousBlocklist -Force
Write-Log "INFO: Update completed successfully"