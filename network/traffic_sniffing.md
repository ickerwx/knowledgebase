# Packet Sniffing

## Use `netsh` to capture traffic

https://blogs.msdn.microsoft.com/canberrapfe/2012/03/30/capture-a-network-trace-without-installing-anything-capture-a-network-trace-of-a-reboot/

### Sniff the traffic

If you need to capture a network trace of a client or server without installing Wireshark or Netmon this might be helpful for you. (This feature works on Windows 7/2008 R2 and above).

1. Open an elevated command prompt and run: "netsh trace start persistent=yes capture=yes tracefile=c:\temp\nettrace-boot.etl" (make sure you have a \temp directory or choose another location).
2. Reproduce the issue or do a reboot if you are tracing a slow boot scenario.
3. Open an elevated command prompt and run: "netsh trace stop"

Your trace will be stored in c:\temp\nettrace-boot.etl or where ever you saved it. You can view the trace on another machine using netmon.

### View the trace

Now that you have the trace, you can take it to a machine where installing netmon is more appropriate to view the data. For customers, I capture using the netsh switch then get permission to view the data on my machine where I have netmon installed. Netmon allows us to choose .etl as a file to open as if it was an .cap file from a traditional trace. When you open the file you might find that it looks a bit rubbish at first

All you need to do is go to the tools > options tab so that you can tell netmon which parsers to use to convert the trace: click on Parser Profiles, select Windows, Set As Active.


## Wireshark useful commands

### Filtering

Show only SMTP (port 25) and ICMP traffic
```
tcp.port eq 25 or icmp
```

Show what POP trafic goes to IP
```
ip.dst eq 172.16.0.1 and pop
```

Show only traffic in the LAN (192.168.x.x), between workstations and servers
```
ip.src==192.168.0.0/16 and ip.dst==192.168.0.0/16
```

Filter out noise, while watching Windows Client - DC exchanges
```
smb || nbns
smb || nbns || dcerpc || nbss || dns
```

Filter HTTP Post Requests
```
ip.dst == 176.28.31.132 && ip.src == 192.168.2.107 && http && http.request.method == POST
```

Display filter to hide duplicate packets
```
not tcp.analysis.retransmission and not tcp.analysis.fast_retransmission and not tcp.analysis.duplicate_ack
```

### Wireshark Decrypt SSL

More info: https://wiki.wireshark.org/SSL

Menu -> Edit -> Preferences ->  Protocols -> SSL -> RSA keys -> Edit > New "+" -> Set:
IP 10.10..
PORT 443
Protocol http
Key File: bundle.pem
Password: (empty)
-> Set: (Pre)-Master-Secret log filename: i.e: secrets.log
-> OK

Filter:
ip.addr == 10.10.20.13 && ssl

Debuging:
-> Set debug file: debug_wiershark.log

Key Formats conversion
The fileformat needed is 'PEM'. It is common practice on webservers to combine public key (or certificate) and the private key in a single PEM file. In that case - cut and paste the section headed by 'PRIVATE KEY' (including header and footer) into a new 'file.key' file.

##  Capture packets with TShark

```cheat tshark Capture packets
tshark -n -i eth0 -w test-capture.pcap
```

```cheat tshark Stop capture when there are 3000 files with 10000kb size
-a files:3000 -b filesize:10000
```

```cheat tshark Capture only tcp and not host xx
-f 'tcp and (!host xxx.xxx.xxx.xxx)'
```

## TCPdump

### Monitor everything on eth0 and write immediately to disk

```cheat tcpdump Capture everything, write to disk immediately
tcpdump -i eth0 -n -U -w everything.pcap
```

### Monitor DHCP & ARP Requests + Responses

```cheat tcpdump Capure DHCP and ARP
tcpdump -i eth0 arp or port 67 or port 68 -e -n -w dhcp.pcap
```

### Read the captured pcap file

```cheat tcpdump Read captured pcap file
tcpdump -ttttnnr dhcp.pcap
```

tags: wireshark windows netsh sniffing admin netmon links [decrypt https] ssl https
