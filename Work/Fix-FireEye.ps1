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

# Task Scheduler.

# Adobe and browser updater tasks that are done automatically without Task Scheduler.
Disable-ScheduledTask -TaskPath "\" -TaskName "Adobe Acrobat Update Task"
Disable-ScheduledTask -TaskPath "\" -TaskName "GoogleUpdateTaskMachineCore"
Disable-ScheduledTask -TaskPath "\" -TaskName "GoogleUpdateTaskMachineUA"
Disable-ScheduledTask -TaskPath "\" -TaskName "MicrosoftEdgeUpdateTaskMachineCore"
Disable-ScheduledTask -TaskPath "\" -TaskName "MicrosoftEdgeUpdateTaskMachineUA"

# Application Experience - Telemetry.
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Application Experience\" -TaskName "Microsoft Compatibility Appraiser"
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Application Experience\" -TaskName "PcaPatchDbTask"
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Application Experience\" -TaskName "ProgramDataUpdater"
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Application Experience\" -TaskName "StartupAppTask"

# Autochk - Causes proxy issues.
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Autochk\" -TaskName "Proxy"

# CloudExperienceHost - Telemetry.
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\CloudExperienceHost\" -TaskName "CreateObjectTask"

# Windows Cusotmer Experience - Telemetry.
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Customer Experience Improvement Program\" -TaskName "Consolidator"
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Customer Experience Improvement Program\" -TaskName "KernelCeipTask"
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Customer Experience Improvement Program\" -TaskName "UsbCeip"

# Windows System Assessment Tool - Random performance tests.
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Maintenance\" -TaskName "WinSAT"

# Windows Error Reporting Upload - Telemetry.
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\Windows Error Reporting\" -TaskName "QueueReporting"

# Xbox Live - Telemetry.
Disable-ScheduledTask -TaskPath "\Microsoft\XblGameSave\" -TaskName "XblGameSaveTask"

# Services.

# Windows Error Reporting.
Stop-Service -Name "WerSvc" -Force
Set-Service -Name "WerSvc" -Status Stopped -StartupType Disabled

# Xbox Live - Telemetry.
Stop-Service -Name "XboxGipSvc" -Force
Stop-Service -Name "XblAuthManager" -Force
Stop-Service -Name "XblGameSave" -Force
Stop-Service -Name "XboxNetApiSvc" -Force
Set-Service -Name "XboxGipSvc" -Status Stopped -StartupType Disabled
Set-Service -Name "XblAuthManager" -Status Stopped -StartupType Disabled
Set-Service -Name "XblGameSave" -Status Stopped -StartupType Disabled
Set-Service -Name "XboxNetApiSvc" -Status Stopped -StartupType Disabled
