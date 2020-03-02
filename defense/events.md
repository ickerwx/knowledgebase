# Interesting Windows Events

## Account Logon

- 4768 Authentication Ticket TGT
- 4776 Credential Validation
- 4624 Logon, Start of Login Session
  - has login types
    - type 2 interactive - GUI
    - type 3 Network - net use
    - type 10 RemoteInteractive (RDP)
- 4625 account failed to log on

Logging in with local credentials will not create a DC log entry

Lateral movement/pivoting will create 4776 events

## System events

- 7045 Service installed
- 7036 Service entered running state
- 7040 service changed from aito-start to disabled

- ServiceName and cmdline fields

- Windows will only log start and stop of MS services

### Enable Non-MS Service Logging

- SC QUERY > Svcs.txt Provides the name of each service (SERVICE_NAME)
- SC SDSHOW <the_service_name_you_want_to_monitor> > sd.txt Provides the current DACL
- SC SDSET <the_service_name_you_want_to_monitor> <the_big_DACL_string>
  - Add this to the end of the DACL
    - (AU;SAFA;RPWPDT;;;WD)
- Modify these two Object Access subcategories to ENABLE, if not already set
  - Auditpol /set /subcategory:"Handle Manipulation" /success:enable /failure:disable
  - Auditpol /set /subcategory:"Other Object Access Events" /success:enable /failure:disable
- Test by stopping and starting the service and then checking the Security log for a 4656 event and the service you adjusted the settings

## Tasks

- 4698 scheduled task was created
- 4699 scheduled task was deleted
- 4702 task modified

- there are also events 129 - created and 141 - deleted in taskscheduler log

- task name, command line and arguments

## Process Creation

- 4688 new process has been created

- Logon ID, process name, command line, creator process ID
- lateral movement over WMI will always spawn c:\windows\system32\wbem\wmiprvse.exe
  - take the process ID and look for child processes (Creator Process ID)
- Chrome will generate a high volume of 4688 events

- Windows 10 will give you the creator process name
  - check for unusual creator processes like Office, Adobe Reader
  - in versions < Win10 cross-reference Creator Process ID

## DCOM MMC20

- will create a new process (see above), with process name mmc.exe
  - so mmc.exe will spawn your child processes

- lateral movement using DCOM ShellWindows and ShellBrowserWindow create no pattern (according to Mauricio Velazco, see links)

## WinRM Windows Remote Management

- winrshosts.exe seems to spawn child processes, can be used to detect lateral movement
- also seems to be the case with wsmprovhost.exe

## Log clearing

- 104 in System Log - Application or System log was cleared
- 1102 in security log - audit log was cleared

## Accounts

- 4720 account created
- 4724 reset account password
- 4735 local group changed
- 4738 user account password changed

## AppLocker

- AppLocker events are 8000-8027
- 8004 - Filename not allowed to running
- 866 in Software Restriction Poilicies (SRP) - Access to <filename> restricted

## Firewall

- 5152 blocked a packet (IP level)
- 5154 permitted application to open a listening socket
- 5156 connection permitted
  - check for direction, source address, source port, destination address, destination port
- 5157 blocked a connection (TCP level)
- 5158 packet drop

- Firewall logging can easily create 10.000 events per hour per system

## Registry

Watch for the creation or modification of new registry keys and values

- 4657 – Accesses: WriteData (or AddFile)
  - HKLM, HKCU & HKU – Software\Microsoft\Windows\CurrentVersion
    - Run, RunOnce
  - HKLM\Software\Microsoft\Windows NT\CurrentVersion\Windows
    - Watch AppInit_Dlls
  - HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\EMDMgmt
    - Watch Connection time of USB Devices
  - HKLM\System\CurrentControlSet\Services
    - Watch for NEW Services
  - HKLM\SYSTEM\CurrentControlSet\Enum\USBSTOR
    - Watch for NEW USB devices

## Further information

- https://www.eventid.net/
- [Michael Gough - Detecting WMI exploitation](https://www.youtube.com/watch?v=w-UFEKR2lO8)
- [Mauricio Velazco, T405 Hunting Lateral Movement for fun and profit at Derbycon 2017](https://www.youtube.com/watch?v=hVTkkkM9XDg)
- [Logging Cheat Sheets](https://www.malwarearchaeology.com/cheat-sheets/)

## Spotting the Adversary (NSA)

- sie empfehlen,`winrm` zu verwenden

```cheat winrm Enable WinRM using quick configure (qc)
# run as Admin
# this opens a listener on *:5985 and configures the service to DelayStart
winrm qc
```

  - WinRM mit `qc` aktiviert Windows Remote Shell (WinRS)
    - das sollte deaktiviert werden
    - liegt unter `Administrative Templates > Windows Components > Windows Remote Shell > Allow Remote Shell Access auf Disabled`

```cheat winrm Deactivate WinRS
winrm set winrm/config/winrs @{AllowRemoteShellAccess="false"}
```

```cheat winrm Display configuration
winrm get winrm/config
```

### AppLocker

- AppLocker Blocks: 8004, 8004 (Error, Warning)
- AppLocker Warning: 8006, 8007 (Error, Warning)
- SRP Block: 865-868, 882 (Warning)

### Windows Service Fails

- Services sollten normalerweise nicht kaputt gehen, sollte analysiert werden
- Events: 7022-7024, 7026, 7031, 7032, 7034 (Error)

### Windows Firewall Logs

- die folgenden Events sollten überwacht werden:
  - Regeln hinzufügen (Firewall Rule Add)
  - Regel ändern (Firewall Rule Change)
  - Regel löschen (Firewall Rule Deleted)
  - Firewall failed to load Group Policy

### Clearing Event Log

- sollte normalerweise im Betrieb nicht passieren
  - Event Log was Cleared (ID 104)
  - Audit Log was Cleared (ID 1102)

### Account Usage

- Account Lockout 4740
- User added to privileged group 4728, 4732, 4756
- Failed Login 4625
- Login with explicit credentials 4648

### Kernel Driver Signing

- Detected an invalid image hash of a file 5038
- Detected an invalid page hash of an image file 6281
- Code integrity check 3001-3004, 3010, 3023
- Failed Kernel Driver loading 219

### Windows Defender

- TODO: muss mal gelesen werden, NSA-Dokument S.29/30

### Pass the hash

- TODO: S.32/33, verstehe ich aktuell nicht, macht irgendwas mit XPath, das lässt sich vermutlich gut nach Splunk übertragen



tags: blueteam windows events siem wmi links services applocker splunk nsa work rene winrm cheat todo
