# Traffic Manipulation

## Arp-Spoofing

`arpspoof -i <interface> -t <target> <who to impersonate>`

## Bypass IP-Whitelisting

First arp spoof the targets gateway to get responses. Then send packets from a lot of possible IPs and monitor to which ips the target answers.

tags: arpspoof spoof arp traffic whitelisting