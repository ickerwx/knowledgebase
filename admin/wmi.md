# Notes on Windows Management Instrumentation WMI

- persistent WMI objects are stored in the WMI repository under `%systemroot%\system32\wbem\repository\objects.data`
- https://github.com/fireeye/flare-wmi

## WMI Utilities

- wmic.exe
- winrm.exe
- wbemtest.exe
- on Linux: wmic, wmis, wmis-pth
- .Net System.Management classes

- WMI service is winmgmt on port 135

## WinRM/Powershell Remoting

- TCP port 5985 (http) or 5986 (https)
- encrypted by default
- protocol based on SOAP/WSMan specification

## WMI Eventing

- WMI can trigger any Eventing
- permanent WMI events are persistent and run as `SYSTEM`
- WMI query language, looks a little like SQL

- WMI events can run code w/o touching disk, will only be stored in `objects.data`

## How to do it

- on powershell: `invoke-wmimethod`
  - example

```powershell cheat wmi Use WMI in Powershell to create processes
PS C:\> invoke-wmimethod -Class win32_Process -Name Create -ArgumentList 'notepad.exe' -ComputerName 192.168.1.2 -Credential 'host\Administrator'
PS C:\> invoke-wmimethod -CN Host Class win32_Process -name create -ArgumentList "c:\foobar.exe" -credential $CRED
```

- using wmic
  - example

```cheat wmi Use wmic to create processes
wmic /user:$USER /password:$PASSWORD /node:$HOST call create "c:\foobar.exe"
```

- andere Optionen

```cheat wmi Other tools to use WMI
wmiexec.py user:pass@host whoami
pth-wmis -U user //host 'whoami'
wmiexec.vbs /cmd host user pass whoami
```

## Mitigations

- stop the service - winmgmt
- firewall DCOM ports
- event logs
  - Microsoft-Windows-WinRM/Operational
  - Microsoft-Windows-WMI-Activity/Operational
  - Microsoft-Windows-DistributedCOM
- preventative permanent WMI event subscriptions to prevent future event subscriptions
- set ACLs on WMI methods

## Videos about WMI
- [Abusing Windows Management Instrumentation (@mattifestation, BH2015)](https://www.youtube.com/watch?v=0SjMgnGwpq8)

tags: windows wmi pentest blueteam redteam powershell talk blackhat
