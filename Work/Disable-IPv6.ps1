## This script would not be made possible if it wasn't for the articles over at "https://www.herlitz.io/2016/09/13/disable-ipv6-on-all-ethernet-adapters-using-powershell/" and "https://4sysops.com/archives/disable-ipv6-in-windows/".

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
$var = ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
if ($var -eq $true)
{
  # Has Admin.
  # Continue.
}
else
{
  # Not Admin.
  Write-Host "Error 5: This script requires administrator rights."
  Read-Host -Prompt "Press Enter to proceed.`n"
  Exit
}
Remove-Variable currentPrincipal
Remove-Variable var

# Disable IPv6 on all network adapters.
Get-NetAdapter | foreach { Disable-NetAdapterBinding -InterfaceAlias $_.Name -ComponentID ms_tcpip6 }

# Check with.
# Get-NetAdapter | foreach { Get-NetAdapterBinding -InterfaceAlias $_.Name -ComponentID ms_tcpip6 }

# Disable IPv6 globally. This is NOT RECOMMENDED as some Services may depend on the local IPv6 stack even if it is not in use by the network-adapters.
# New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\" -Name "DisabledComponents" -Type DWord -Value 255
