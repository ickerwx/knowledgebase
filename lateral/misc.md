# Misc

## mass checking for default credentials on the network

### Ncrack (https://nmap.org/ncrack/)
Examples:
``` 
ncrack <ip>:22 <ip>:21
ncrack <ips> -p 22,ftp:3210,telnet
```

### find gateways/routes to internet 
Gateway-finder (http://pentestmonkey.net/tools/gateway-finder):
```
apt-get install python-scapy
arp-scan -l | tee arp.txt
python gateway-finder.py -f arp.txt -i 209.85.227.99
```

tags: misc gateway 