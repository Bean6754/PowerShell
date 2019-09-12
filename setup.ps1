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

# Enable Remote Desktop.
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\' -Name "fDenyTSConnections" -Value 0
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\' -Name "UserAuthentication" -Value 1

# Disable Remote Assistance.
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance' -Name "fAllowToGetHelp" -Value 0

# Windows Visual Effects.
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects' -Name "VisualFXSetting" -Value 3

$regkey="HKCU:\Control Panel\Desktop"
$attrName="UserPreferencesMask"
$thevalue="90,12,03,80,10,00,00,00"
$hex=$thevalue.split(',') | % {"0x$_"}
Set-ItemProperty -path $RegKey -Name $attrName -Value ([byte[]]$hex)

Remove-Variable hex
Remove-Variable thevalue
Remove-Variable attrName
Remove-Variable regkey

New-Item -Path 'HKCU:\Control Panel\Desktop\WindowMetrics' -Name "MinAnimate" -Force
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\WindowMetrics' -Name "MinAnimate" -Value 0

New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name "TaskbarAnimations" -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name "TaskbarAnimations" -Value 0

New-Item -Path 'HKCU:\Software\Microsoft\Windows\DWM' -Name "EnableAeroPeek" -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\DWM' -Name "EnableAeroPeek" -Value 0

New-Item -Path 'HKCU:\Software\Microsoft\Windows\DWM' -Name "AlwaysHibernateThumbnails" -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\DWM' -Name "AlwaysHibernateThumbnails" -Value 0

New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name "IconsOnly" -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name "IconsOnly" -Value 1

New-Item -Path 'HKCU:\Control Panel\Desktop' -Name "DragFullWindows" -Force
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name "DragFullWindows" -Value 1

New-Item -Path 'HKCU:\Control Panel\Desktop' -Name "FontSmoothing" -Force
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name "FontSmoothing" -Value 2

New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name "ListviewShadow" -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name "ListviewShadow" -Value 0


# Don't show recently added programs in Start Menu.
New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name "HideRecentlyAddedApps" -Force
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name "HideRecentlyAddedApps" -Value 1

# Hide Cortana button on taskbar.
New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows' -Name "AllowCortana" -Force
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows' -Name "AllowCortana" -Value 0

# Hide search bar on taskbar.
New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name "SearchboxTaskbar" -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name "SearchboxTaskbar" -Value 0

# Enable taskview button on taskbar.
New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\MultiTaskingView\AllUpView' -Name "Enabled" -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\MultiTaskingView\AllUpView' -Name "Enabled" -Value 1

# Show hidden files.
New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name "Hidden" -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name "Hidden" -Value 1

# Show filename extension.
New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name "HideFileExt" -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name "HideFileExt" -Value 0

# Show true file path.
New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name "DontPrettyPath" -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name "DontPrettyPath" -Value 1

# Disable QuickAccess.
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
New-Item -Path 'HKCR:\CLSID{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder' -Name "Attributes" -Force
Set-ItemProperty -Path 'HKCR:\CLSID{679f85cb-0220-4080-b29b-5540cc05aab6}\ShellFolder' -Name "Attributes" -Value a0600000

# Set Explorer to This PC instead of QuickAccess.
New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name "LaunchTo" -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name "LaunchTo" -Value 1

.\programs.ps1
