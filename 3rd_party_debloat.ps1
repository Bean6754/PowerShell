# This script will try to debloat most third party applications on Windows 10.

param([switch]$Elevated)

function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) 
    {
        # tried to elevate, did not work, aborting
    } 
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}

exit
}

'running with full privileges'

# The CandyCrushes.
Get-AppxPackage *candycrush* | Remove-AppxPackage

# Dolby Access.
Get-AppxPackage *dolbyaccess* | Remove-AppxPackage

# Hidden City.
Get-AppxPackage *hiddencity* | Remove-AppxPackage

# March of Empires.
Get-AppxPackage *marchofempires* | Remove-AppxPackage

# Minecraft (not technically third-party anymore).
Get-AppxPackage *minecraft* | Remove-AppxPackage
