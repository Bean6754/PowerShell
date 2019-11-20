# Country dependent: DomainName, Hostname and TimeZone.
# NOTE: Clear-Variable sets var data to NULL; Remove-Variable actually deletes the variable.


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

# Add adminSD.
Clear-Host

$op = Get-LocalUser | Where-Object {$_.Name -eq "adminSD"}
if ($op -Like "adminSD")
{
  Write-Host "adminSD already exists."
}
else
{
  Write-Host "Enter super-secure password for adminSD."
  $password = Read-Host -AsSecureString
  New-LocalUser -Name "adminSD" -Password $password -PasswordNeverExpires -UserMayNotChangePassword
  Remove-Variable password
  # Add adminSD to Administrators local group.
  Add-LocalGroupMember -Group "Administrators" -Member "adminSD"
}
Remove-Variable op

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

$snVar1 = (Get-CimInstance win32_bios | Format-List serialnumber) | Out-String
$snVar2 = ($snVar1 -Replace "serialnumber : " -Replace "")
$snVar3 = ($snVar2 -Replace "`t|`n|`r" -Replace ", ")
$snVar = ($snVar3.ToString())
Remove-Variable snVar1
Remove-Variable snVar2
Remove-Variable snVar3

Rename-Computer -NewName PCUKNPT-$snVar
Remove-Variable snVar

# Join the domain if not done yet.
if ((Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain -eq $true)
{
  Write-Host "Computer is already on the domain."
}
else
{
  Add-Computer -DomainName uk.enersys.group
}

Clear-Host
Write-Host "Please restart computer to:`nUpdate hostname.`nPlease also drag the computer into the correct OU in Active Directory.`n"
Read-Host -Prompt "Press Enter once you have rebooted, done what's needed and re-ran this script.`n"

# gpupdate.
$command = "/c echo n | gpupdate /force /wait:0"
Start-Process "cmd" -ArgumentList "$command" -Verb runAs -Wait
Remove-Variable command


# Set UK keyboard as default and only layout.
# Set-WinUserLanguageList -LanguageList en-US, en-GB -Force (for multiple keyboard layouts)
Set-WinUserLanguageList -LanguageList en-GB -Force

# Set Timezone.
Set-TimeZone "GMT Standard Time"
# Get-TimeZone -ListAvailable

# Sync with NTP.
Start-Process "w32tm.exe" -ArgumentList ("/config", "/update") -Verb runAs -Wait
Start-Process "w32tm.exe" -ArgumentList "/resync" -Verb runAs -Wait

.\Fix-FireEye.ps1
Visual-C-Runtimes-All-in-One-Sep-2019\install_all.bat

# Install Programs.
Start-Process -FilePath ".\ChromeStandaloneSetup64"
Start-Process -FilePath ".\7z1900-x64.exe" -Wait
Start-Process -FilePath ".\vlc-3.0.8-win64.exe" -Wait
Start-Process -FilePath ".\Greenshot-INSTALLER-1.2.10.6-RELEASE.exe" -Wait
# Start-Process -FilePath ".\notepad" -Wait
Start-Process ".\AdobeAcroCleaner_DC2015.exe" -ArgumentList ("/silent", "/product=0") -Verb runAs -Wait
Start-Process ".\AdobeAcroCleaner_DC2015.exe" -ArgumentList ("/silent", "/product=1") -Verb runAs -Wait
Start-Process -FilePath ".\AcroRdrDC1901220034_en_US" -Wait
Start-Process -FilePath ".\NOTES_9.0.1_WIN_EN" -Wait
Start-Process -FilePath ".\901FP10SHF81_W32_standard.exe" -Wait

# $outputVar = (netsh wlan show wirelesscapabilities | Select-String -Pattern "Station") | Out-String
$outputVar = (Get-NetAdapter | Where-Object { $_.PhysicalMediaType -eq "Native 802.11" -or $_.PhysicalMediaType -eq "Wireless LAN" -or $_.PhysicalMediaType -eq "Wireless WAN"}) | Out-String

if ($outputVar -Like "*Name*")
{
  # Has WiFi, legacy WiFi or cellular.
  # Start-Process -FilePath ".\E80_92_CheckPointVPN.msi" -Wait
  Start-Process -FilePath ".\cpextender.msi" -Wait
  Start-Process -FilePath ".\SNXComponentsShell.msi" -Wait
}
else
{
  # Doesn't or undetected.
}

# Wait for user to setup and test VPN first.
# Then install ForcePoint.
Set-Location -Path "forcepoint_2019"
$curDir = (Get-Location).ToString()
$command = ('/c cd ' + $curDir + ' & FORCEPOINT-ONE-ENDPOINT-x64.exe /v"WSCONTEXT=a7a98e95569ae326bb3ca74c4a77744b-0"')
Start-Process "cmd" -ArgumentList "$command" -Verb runAs -Wait
Set-Location -Path ".."
Remove-Variable curDir
Remove-Variable command

Start-Process -FilePath ".\FramePkg.exe" # McAfee Anti-Malware. Don't use '-Wait'.
