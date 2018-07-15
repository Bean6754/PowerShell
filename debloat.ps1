# This script will mostly debloat Windows 10.
# Thanks to: https://www.howtogeek.com/224798/how-to-uninstall-windows-10s-built-in-apps-and-how-to-reinstall-them/



# Uninstall 3D Builder:
Get-AppxPackage *3dbuilder* | Remove-AppxPackage
# Uninstall Alarms and Clock:
Get-AppxPackage *windowsalarms* | Remove-AppxPackage
# Uninstall Calculator:
# Get-AppxPackage *windowscalculator* | Remove-AppxPackage
# Uninstall Calendar and Mail:
Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage
# Uninstall Camera:
# Get-AppxPackage *windowscamera* | Remove-AppxPackage
# Uninstall Contact Support:
# This app can't be removed.
# Uninstall Cortana:
# This app can't be removed.
# Uninstall Get Office:
Get-AppxPackage *officehub* | Remove-AppxPackage
# Uninstall Get Skype:
Get-AppxPackage *skypeapp* | Remove-AppxPackage
# Uninstall Get Started:
Get-AppxPackage *getstarted* | Remove-AppxPackage
# Uninstall Groove Music:
Get-AppxPackage *zunemusic* | Remove-AppxPackage
# Uninstall Maps:
Get-AppxPackage *windowsmaps* | Remove-AppxPackage
# Uninstall Microsoft Edge:
# This app can't be removed.
# Uninstall Microsoft Solitaire Collection:
Get-AppxPackage *solitairecollection* | Remove-AppxPackage
# Uninstall Money:
Get-AppxPackage *bingfinance* | Remove-AppxPackage
# Uninstall Movies & TV:
Get-AppxPackage *zunevideo* | Remove-AppxPackage
# Uninstall News:
Get-AppxPackage *bingnews* | Remove-AppxPackage
# Uninstall OneNote:
Get-AppxPackage *onenote* | Remove-AppxPackage
# Uninstall People:
Get-AppxPackage *people* | Remove-AppxPackage
# Uninstall Phone Companion:
# Get-AppxPackage *windowsphone* | Remove-AppxPackage
# Uninstall Photos:
# Get-AppxPackage *photos* | Remove-AppxPackage
# Uninstall Store:
# Get-AppxPackage *windowsstore* | Remove-AppxPackage
# Uninstall Sports:
Get-AppxPackage *bingsports* | Remove-AppxPackage
# Uninstall Voice Recorder:
# Get-AppxPackage *soundrecorder* | Remove-AppxPackage
# Uninstall Weather:
Get-AppxPackage *bingweather* | Remove-AppxPackage
# Uninstall Windows Feedback:
# This app can't be removed.
# Uninstall Xbox:
# Get-AppxPackage *xboxapp* | Remove-AppxPackage
