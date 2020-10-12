# Scanning

## Nmap
Host Discovery (via ping):
`nmap -sP -sn <targets>`
Fast scan to start working:
`nmap -Pn -sC -sV <ip> -oA <out>`
Complete tcp scan:
`nmap -p- -Pn -sC -sV <ip> -oA <out>`
Fast udp scan:
`nmap -Pn --top-ports=100 -sC -sV -sU <ip> -oA <out>`

## Gateway-Finder
`python gateway-finder.py -f arp.txt -i 209.85.227.99`

## Other
Arpscan to discover mac-addresses in local subnet:
`arp-scan -l | tee <name>.txt`

Bash portscan:
```
for p in {1..65535}; do echo hi > /dev/tcp/172.19.0.2/$p && echo port $p is open > scan 2>/dev/null; done 
```

Powershell portscan:
```
0..65535 | % {echo ((new-object Net.Sockets.TcpClient).Connect("<ip>",$_)) "Port $_ is open!"} 2>$null
```

## Enumerate SMB-Shares
`nmap -vv -n -p 445 --script smb-enum-shares.nse --script-args smbdomain='',smbuser='',smbpass='' -oA <output>`


### Nmap-Diffing
Can be used as cronjob to run nmap everyday and see differences in scans.
```
#!/bin/bash

mkdir /opt/nmap_diff
d=$(date +%Y-%m-%d)
y=$(date -d yesterday +%Y-%m-%d)
/usr/bin/nmap -T4 -oX /opt/nmap_diff/scan_$d.xml <iprange> > /dev/null 2>&1
if [ -e /opt/nmap_diff/scan_$y.xml ]; then
	/usr/bin/ndiff/opt/nmap_diff/scan_$y.xml
/opt/nmap_diff/scan_$d.xml > /opt/nmap_diff/diff.txt
fi
```

tags: #nmap #arp #gateway #finder #scanning 
