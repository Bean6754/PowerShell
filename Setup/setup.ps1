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

# Set pagefile to 8192 MB.
$computersys = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges;
$computersys.AutomaticManagedPagefile = $False;
$computersys.Put();
$pagefile = Get-WmiObject -Query "Select * From Win32_PageFileSetting Where Name like '%pagefile.sys'";
$pagefile.InitialSize = 8192;
$pagefile.MaximumSize = 8192;
$pagefile.Put();

Remove-Variable pagefile
Remove-Variable computersys

# Set hostname to "DESKTOP".
Rename-Computer "DESKTOP"

# Set Timezone.
Set-TimeZone "GMT Standard Time"
# Get-TimeZone -ListAvailable

# Sync with NTP.
Start-Process "w32tm.exe" -ArgumentList ("/config", "/update") -Verb runAs -Wait
Start-Process "w32tm.exe" -ArgumentList "/resync" -Verb runAs -Wait

# Set US keyboard as default and only layout.
# Set-WinUserLanguageList -LanguageList en-US, en-GB -Force (for multiple keyboard layouts)
Set-WinUserLanguageList -LanguageList en-US -Force

# Set BitLocker to AES-256bit and enable TPM.
reg import "reg\bitlocker.reg"

# Enable Remote Desktop and disable remote assistance.
reg import "reg\remote-desktop.reg"

# Disable web-search for Windows 10 Start Menu.
reg import "reg\web-search.reg"

# Windows Visual Effects.
reg import "reg\visual.reg"

# Don't show recently added programs in Start Menu.
reg import "reg\start-menu.reg"

# Explorer options.
reg import "reg\explorer.reg"
