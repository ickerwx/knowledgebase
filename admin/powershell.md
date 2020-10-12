# Nützliche Powershell-Snippets

### MS Technet Script Resources

https://gallery.technet.microsoft.com/scriptcenter

### Powershell for Penetration Testing

https://github.com/samratashok/nishang
https://github.com/mattifestation/PowerSploit

### zeige Attribute/Methoden eines Objektes

```powershell
$obj | Get-Member
```

### Execution-Policy ändern

```powershell
Set-ExecutionPolicy -Scope Process unrestricted
```

### For-Schleife über Ordnerinhalt

```powershell
foreach ($file in Get-ChildItem) {
..\radare2-w32-0.9.9-git\rahash2.exe $file.name
}
```

### Netzwerkadapter anzeigen

```powershell
Get-WmiObject -Class Win32_NetworkAdapter | ft -a
```

### Liste Dienste auf

```powershell
Get-WmiObject win32_service | select Name, DisplayName, State, PathName
Get-WmiObject win32_service | ?{$_.Name -like '*sql*'} | select Name, DisplayName, State, PathName
```

pipen nach ~Format-List oder ~Format-Table für besseres output

### Durchsuchen nach allen Dateien und Anzeigen der Rechte

```powershell
get-childitem "C:\" -recurse | get-acl | format-list > find_all_files.txt
```

### Finde die größten Dateien im aktuellen Ordner

```powershell
gci -r | sort Length -desc | select fullname,length -f 20 |ft -a

gci = get-childitem
-r rekursiv
```

absteigend nach Länge sortieren filtert Ordner raus, die haben Length

### base64 in PS

#### decode string

```powershell
[System.Text.Encoding]::UTF8.GetString(System.Convert::FromBase64String("YmxhaGJsYWg="))
[Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('MTIzCg=='))
[Text.Encoding]::ASCII.GetString([Convert]::FromBase64String('MTIzCg=='))
```

#### encode string

```powershell
[System.Convert]::ToBase64String(System.Text.Encoding::UTF8.GetBytes("nVnV"))
```

### Download einer Datei

```powershell
(New-Object System.Net.WebClient) 
.DownloadFile( 
 "http://mysite.com/nc.exe", 
  "c:\nc.exe" 
) 
```

### Powershell curl replacement

```powershell
(New-Object System.Net.WebClient).DownloadString("https://")
```

### List network services

```powershell
function Get-NetworkStatistics
{
	[OutputType('System.Management.Automation.PSObject')]
	[CmdletBinding(DefaultParameterSetName='name')]
	
	param(
		[Parameter(Position=0,ValueFromPipeline=$true,ParameterSetName='port')]
		[System.Int32]$Port='*',
		
		[Parameter(Position=0,ValueFromPipeline=$true,ParameterSetName='name')]
		[System.String]$ProcessName='*',
		
		[Parameter(Position=0,ValueFromPipeline=$true,ParameterSetName='address')]
		[System.String]$Address='*',		
		
		[Parameter()]
		[ValidateSet('*','tcp','udp')]
		[System.String]$Protocol='*',

		[Parameter()]
		[ValidateSet('*','Closed','CloseWait','Closing','DeleteTcb','Established','FinWait1','FinWait2','LastAck','Listen','SynReceived','SynSent','TimeWait','Unknown')]
		[System.String]$State='*'
		
	)
    
	begin
	{
		$properties = 'Protocol','LocalAddress','LocalPort'
    		$properties += 'RemoteAddress','RemotePort','State','ProcessName','PID'
	}
	
	process
	{
	    netstat -ano | Select-String -Pattern '\s+(TCP|UDP)' | ForEach-Object {

	        $item = $_.line.split(' ',[System.StringSplitOptions]::RemoveEmptyEntries)

	        if($item[1] -notmatch '^\[::')
	        {           
	            if (($la = $item[1] -as [ipaddress]).AddressFamily -eq 'InterNetworkV6')
	            {
	               $localAddress = $la.IPAddressToString
	               $localPort = $item[1].split('\]:')[-1]
	            }
	            else
	            {
	                $localAddress = $item[1].split(':')[0]
	                $localPort = $item[1].split(':')[-1]
	            } 

	            if (($ra = $item[2] -as [ipaddress]).AddressFamily -eq 'InterNetworkV6')
	            {
	               $remoteAddress = $ra.IPAddressToString
	               $remotePort = $item[2].split('\]:')[-1]
	            }
	            else
	            {
	               $remoteAddress = $item[2].split(':')[0]
	               $remotePort = $item[2].split(':')[-1]
	            } 
				
				$procId = $item[-1]
				$procName = (Get-Process -Id $item[-1] -ErrorAction SilentlyContinue).Name
				$proto = $item[0]
				$status = if($item[0] -eq 'tcp') {$item[3]} else {$null}				
				
				
				$pso = New-Object -TypeName PSObject -Property @{
					PID = $procId
					ProcessName = $procName
					Protocol = $proto
					LocalAddress = $localAddress
					LocalPort = $localPort
					RemoteAddress =$remoteAddress
					RemotePort = $remotePort
					State = $status
				} | Select-Object -Property $properties								


				if($PSCmdlet.ParameterSetName -eq 'port')
				{
					if($pso.RemotePort -like $Port -or $pso.LocalPort -like $Port)
					{
					    if($pso.Protocol -like $Protocol -and $pso.State -like $State)
						{
							$pso
						}
					}
				}

				if($PSCmdlet.ParameterSetName -eq 'address')
				{
					if($pso.RemoteAddress -like $Address -or $pso.LocalAddress -like $Address)
					{
					    if($pso.Protocol -like $Protocol -and $pso.State -like $State)
						{
							$pso
						}
					}
				}
				
				if($PSCmdlet.ParameterSetName -eq 'name')
				{		
					if($pso.ProcessName -like $ProcessName)
					{
						if($pso.Protocol -like $Protocol -and $pso.State -like $State)
						{
					   		$pso
						}
					}
				}
	        }
	    }
	}
<#

.SYNOPSIS
	Displays the current TCP/IP connections.

.DESCRIPTION
	Displays active TCP connections and includes the process ID (PID) and Name for each connection.
	If the port is not yet established, the port number is shown as an asterisk (*).	
	
.PARAMETER ProcessName
	Gets connections by the name of the process. The default value is '*'.
	
.PARAMETER Port
	The port number of the local computer or remote computer. The default value is '*'.

.PARAMETER Address
	Gets connections by the IP address of the connection, local or remote. Wildcard is supported. The default value is '*'.

.PARAMETER Protocol
	The name of the protocol (TCP or UDP). The default value is '*' (all)
	
.PARAMETER State
	Indicates the state of a TCP connection. The possible states are as follows:
		
	Closed	 	- The TCP connection is closed. 
	CloseWait 	- The local endpoint of the TCP connection is waiting for a connection termination request from the local user. 
	Closing 	- The local endpoint of the TCP connection is waiting for an acknowledgement of the connection termination request sent previously. 
	DeleteTcb 	- The transmission control buffer (TCB) for the TCP connection is being deleted. 
	Established 	- The TCP handshake is complete. The connection has been established and data can be sent. 
	FinWait1 	- The local endpoint of the TCP connection is waiting for a connection termination request from the remote endpoint or for an acknowledgement of the connection termination request sent previously. 
	FinWait2 	- The local endpoint of the TCP connection is waiting for a connection termination request from the remote endpoint. 
	LastAck 	- The local endpoint of the TCP connection is waiting for the final acknowledgement of the connection termination request sent previously. 
	Listen	 	- The local endpoint of the TCP connection is listening for a connection request from any remote endpoint. 
	SynReceived 	- The local endpoint of the TCP connection has sent and received a connection request and is waiting for an acknowledgment. 
	SynSent 	- The local endpoint of the TCP connection has sent the remote endpoint a segment header with the synchronize (SYN) control bit set and is waiting for a matching connection request. 
	TimeWait	- The local endpoint of the TCP connection is waiting for enough time to pass to ensure that the remote endpoint received the acknowledgement of its connection termination request. 
	Unknown		- The TCP connection state is unknown.
	
	Values are based on the TcpState Enumeration:
	http://msdn.microsoft.com/en-us/library/system.net.networkinformation.tcpstate%28VS.85%29.aspx

.EXAMPLE
	Get-NetworkStatistics

.EXAMPLE
	Get-NetworkStatistics iexplore

.EXAMPLE
	Get-NetworkStatistics -ProcessName md* -Protocol tcp 

.EXAMPLE
	Get-NetworkStatistics -Address 192* -State LISTENING 

.EXAMPLE
	Get-NetworkStatistics -State LISTENING -Protocol tcp

.OUTPUTS
	System.Management.Automation.PSObject

.NOTES
	Author: Shay Levy
	Blog  : http://PowerShay.com
#>	
}

help Get-NetworkStatistics
```

In der Powershell zunächst ```Set-ExecutionPolicy -Scope Process unrestricted``` ausführen. Den obigen Code in Datei name.ps1 speichern, dann in der Shell . .\name.ps1 eingeben zum sourcen. Danach steht ```get-networkstatistics``` zur Verfügung.

schamlos kopiert von http://poshcode.org/2701

##  Portscanner

```powershell
PS C:\> 1..1024 | % {  
echo  
 ((new-object Net.Sockets.TcpClient) 
 .Connect("10.1.1.14",$_)) "$_ is open"  
} 2>$null 
25 is open
```

## Zeige angemeldete Nutzer

```powershell
function Get-LoggedOnUser {
#Requires -Version 2.0            
[CmdletBinding()]            
 Param             
   (                       
    [Parameter(Mandatory=$true,
               Position=0,                          
               ValueFromPipeline=$true,            
               ValueFromPipelineByPropertyName=$true)]            
    [String[]]$ComputerName
   )#End Param

Begin            
{            
 Write-Host "`n Checking Users . . . "
 $i = 0            
}#Begin          
Process            
{
    $ComputerName | Foreach-object {
    $Computer = $_
    try
        {
            $processinfo = @(Get-WmiObject -class win32_process -ComputerName $Computer -EA "Stop")
                if ($processinfo)
                {    
                    $processinfo | Foreach-Object {$_.GetOwner().User} | 
                    Where-Object {$_ -ne "NETWORK SERVICE" -and $_ -ne "LOCAL SERVICE" -and $_ -ne "SYSTEM"} |
                    Sort-Object -Unique |
                    ForEach-Object { New-Object psobject -Property @{Computer=$Computer;LoggedOn=$_} } | 
                    Select-Object Computer,LoggedOn
                }#If
        }
    catch
        {
            "Cannot find any processes running on $computer" | Out-Host
        }
     }#Foreach-object(ComputerName)                  
}#Process
End
{
}#End
}#Get-LoggedOnUser
```


ndows command line snippets

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

## Alle Commandlets auflisten

```
Get-Command -CommandType cmdlet
Get-Command -Module <modulename>
```

tags: #windows #snippets #pentest #wmi #powershell #audit #netsh #firewall #taskkill #vmware #links 
