# Windows command line snippets

## List stored credentials

```
c:\windows\system32\cmdkey /list
```

## Find domain controller

```
echo %LOGONSERVER%
nltest /dsgetdc:<domain-name>
nltest /dclist:<domain-name>
nslookup -type=SRV _ldap._tcp.pdc._msdcs.<domain-name>
```

## List drives

```
wmic logicaldisk get name|caption
wmic logicaldisk get deviceid, volumename, description
fdutil fsinfo drives
diskpart
    list volumes
```

```powershell
get-psdrive -psprovider filesystem
```

## List drivers

```
driverquery -FO list /v
```

## List firewall rules

```
netsh advfirewall show rule name=all profile=domain verbose
```

## Print the stored WLAN keys

Open admin cmd
```
netsh wlan show profile NAME key=clear
```
Replace `NAME` with the AP name you are interested in.

## Read partial Files
PS Partial Reading: `Get-Content <filename> -Head n (or -Tail n)`


## Run cmd.exe commands from Powershell
`cmd.exe /c <command>` 


## Pkill for windows

```
taskkill /F /IM <name> /T`
```

## Switch Activation Key

```
slmgr /dlv
slmgr /upk <activation id>
to install `slmgr /ipk`
```

## Hyper-V deaktivieren

Ich hatte das Problem, dass VMware nicht mehr gestartet ist, weil Hyper-V/Credential Guard/Device Guard aktiv war. Abschalten kann man Hyper-V so:

```
bcdedit /set hypervisorlaunchtype off
```

Nach einem Neustart kann man wieder virtuelle Maschinen starten.

tags: windows snippets pentest wmi powershell audit netsh firewall taskkill vmware
