# Fix-FireEye.ps1

What the script does:

Checks if it is ran with Administrator rights otherwise it exits.

_Task Scheduler_

Disables `Office ClickToRun Service Monitor`, `OfficeTelemetryAgentFallBack2016` and `OfficeTelemetryAgentLogOn2016` .

![Office ClickToRun Service Monitor](/images/office.png "Office ClickToRun Service Monitor")

Disables `MareBackup`, `Microsoft Compatibility Appraiser`, `PcaPatchDbTask`, `ProgramDataUpdater` and `StartupAppTask`.

![Application Experience](images/application-experience.png "Application Experience")

Disables `Proxy`.

![Autochk](images/autochk.png "Autochk")

Disables `Create Object Task`.

![Cloud Experience Host](images/createobjtask.png "Cloud Experience Host")

Disables `Consolidator`, `KernelCeipTask` (only found in Windows 7) and `UsbCeip`.

![Spyware](images/spyware.png "Spyware")

Disables `WinSAT`.

![Maintenance](images/maintenance.png "Maintenance")

Disables `QueueReporting`.

![Windows Error Reporting](images/winerror-reporting.png "Windows Error Reporting")

_Services_

Disables `Windows Error Reporting`.

![Windows Error Reporting Service](images/svc-winerror-reporting.png "Windows Error Reporting Service")

Disables `Xbox Accessory Management Service`.

![Xbox Service 1](images/svc-xbox1.png "Xbox Service 1")

Disables `Xbox Live Auth Manager`.

![Xbox Service 2](images/svc-xbox2.png "Xbox Service 2")

Disables `Xbox Live Game Service`.

![Xbox Service 3](images/svc-xbox3.png "Xbox Service 3")

Disables `Xbox Live Networking Service`.

![Xbox Service 4](images/svc-xbox4.png "Xbox Service 4")
