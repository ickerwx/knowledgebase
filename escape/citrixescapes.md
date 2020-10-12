# Citrix Escapes

https://www.pentestpartners.com/security-blog/breaking-out-of-citrix-and-other-restricted-desktop-environments/?doing_wp_cron=1496068536.6803040504455566406250

## Ways to elevate options in a kiosk system
find a way to open up a dialog box
* save as..
* print menu - print to file
  then for example
  * create new files (bat, shortcuts)
  * open explorer
  * right-click for properties -> file location
  * Many input boxes accept file paths; try all inputs with UNC paths such as ```//attacker–pc/``` or ```//127.0.0.1/c$``` or ```C:```
     * enter *.* or *.exe or similar in “File name” box
  * help -> search for command prompt
Right click on any whitespace and select “view source” which will open an instance of notepad
The Print icon at the top can be used to bring up a print dialog
A help menu can be accessed from the Language Bar. This is especially common on systems that need to cater for multiple languages i.e. at airports.
Most applications with a help menu will offer a hyperlink to the vendor webpage (e.g. www.vendor.com). Clicking on the link can be a way of bringing up an Internet Explorer window, and pivoting from there.
* Task manager -> New Task
### Umgebungsvariablen
```
%ALLUSERSPROFILE%
%APPDATA%
%CommonProgramFiles%
%COMMONPROGRAMFILES(x86)%
%COMPUTERNAME%
%COMSPEC%
%HOMEDRIVE%
%HOMEPATH%
%LOCALAPPDATA%
%LOGONSERVER%
%PATH%
%PATHEXT%
%ProgramData%
%ProgramFiles%
%ProgramFiles(x86)%
%PROMPT%
%PSModulePath%
%Public%
%SYSTEMDRIVE%
%SYSTEMROOT%
%TEMP%
%TMP%
%USERDOMAIN%
%USERNAME%
%USERPROFILE%
%WINDIR%
shell:Administrative Tools
shell:DocumentsLibrary
shell:Librariesshell:UserProfiles
shell:Personal
shell:SearchHomeFolder
shell:System shell:NetworkPlacesFolder
shell:SendTo
shell:UserProfiles
shell:Common Administrative Tools
shell:MyComputerFolder
shell:InternetFolder
```
### File Protocol handlers
```
about:
data:
ftp:
mailto:
news:
res:
telnet:
view-source:
```

tags: #windows #pentest #citrix #links 
