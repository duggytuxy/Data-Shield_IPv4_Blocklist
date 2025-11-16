# Requires PowerShell 5.0+
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Variables
$BlocklistUrl = "https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
$BlocklistDir = "C:\FirewallBlocklist"
$PreviousBlocklist = Join-Path $BlocklistDir "previous_blocklist.txt"
$CurrentBlocklist = Join-Path $BlocklistDir "current_blocklist.txt"
$TmpBlocklist = Join-Path $BlocklistDir "tmp_blocklist.txt"
$LogFile = "C:\FirewallBlocklist\firewall_update.log"
$RuleName = "DynamicBlocklist"

# Logging function
function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $LogFile -Value "$timestamp : $Message"
}

# Preparation
if (!(Test-Path $BlocklistDir)) { New-Item -ItemType Directory -Path $BlocklistDir | Out-Null }
if (!(Test-Path $PreviousBlocklist)) { New-Item -ItemType File -Path $PreviousBlocklist | Out-Null }
if (!(Test-Path $LogFile)) { New-Item -ItemType File -Path $LogFile | Out-Null }

# Download blocklist securely
try {
    Invoke-WebRequest -Uri $BlocklistUrl -OutFile $TmpBlocklist -UseBasicParsing
} catch {
    Write-Log "ERROR: Failed to download blocklist from $BlocklistUrl"
    exit 1
}

# Validate IPs and clean up
Get-Content $TmpBlocklist | Where-Object { $_ -match '^\d{1,3}(\.\d{1,3}){3}$' } | Sort-Object -Unique | Set-Content $CurrentBlocklist

# Read IPs
$NewIPs = Get-Content $CurrentBlocklist
$OldIPs = Get-Content $PreviousBlocklist

# Remove old rule if exists
if (Get-NetFirewallRule -DisplayName $RuleName -ErrorAction SilentlyContinue) {
    Remove-NetFirewallRule -DisplayName $RuleName
    Write-Log "INFO: Removed old firewall rule"
}

# Add new rule with updated IPs
if ($NewIPs.Count -gt 0) {
    $RemoteAddresses = $NewIPs -join ","
    New-NetFirewallRule -DisplayName $RuleName -Direction Inbound -Action Block -RemoteAddress $RemoteAddresses
    Write-Log "INFO: Added firewall rule with $($NewIPs.Count) IPs"
}

# Log changes
Compare-Object $OldIPs $NewIPs | ForEach-Object {
    if ($_.SideIndicator -eq "=>") { Write-Log "ADDED: $($_.InputObject)" }
    elseif ($_.SideIndicator -eq "<=") { Write-Log "REMOVED: $($_.InputObject)" }
}

# Save current blocklist for next run
Copy-Item $CurrentBlocklist $PreviousBlocklist -Force
Write-Log "INFO: Update completed successfully"