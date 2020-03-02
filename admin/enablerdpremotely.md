# Enable RDP remotely

via wmic on Windows 2008 and above

```
C:\> wmic /namespace:\\root\CIMV2\TerminalServices PATH Win32_TerminalServiceSetting WHERE (__CLASS !="") CALL SetAllowTSConnections 1
```

tags: windows post-exploitation pentest