# IPV6

## Neighbour discovery
ip -6 neigh

## ping single host
ping6 -I ens160 fe80::250:56ff:feaa:7e86     

## nmap 
nmap -6 dead:beef::250:56ff:feaa:7e86

## ssh + scp
scp -6 users@\[dead:beef::250:56ff:feaa:7e86\]:~ fooo

## Addresses 
ff02::1     All nodes on the local network segment
ff02::2     All routers on the local network segment
ff02::5     OSPFv3 All SPF routers
ff02::6     OSPFv3 All DR routers
ff02::8     IS-IS for IPv6 routers
ff02::9     RIP routers
ff02::a     EIGRP routers
ff02::d     PIM routers
ff02::16    MLDv2 reports
ff02::1:2   All DHCP servers and relay agents on the local network segment
ff02::1:3   All LLMNR hosts on the local network segment
ff05::1:3   All DHCP servers on the local network site
ff0x::c     Simple Service Discovery Protocol
ff0x::fb    Multicast DNS
ff0x::101   Network Time Protocol
ff0x::108   Network Information Service
ff0x::181   Precision Time Protocol (PTP) version 2 messages except peer delay measurement
ff02::6b    Precision Time Protocol (PTP) version 2 peer delay measurement messages
ff0x::114   Experimental

tags: ipv6 networking
