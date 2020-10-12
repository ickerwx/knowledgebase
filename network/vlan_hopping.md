# vlan v-lan Hopping

## CDP and DTP packets broadcasted by the switch
When connected directly to the switch port using the cable normally connected to the Cisco phone.
The broadcasted DTP packet discloses that the trunk is configured as Auto and that it supports the two trunking protocols ISL and 802.1Q:

## Yersinia
Yersinia can be used to enable trunking on Cisco switches by forging DTP packets.
Yersinia’s "enable trunkin" attack sends a DTP packet with status "DESIRABLE" to the switch.
The switch then automatically reconfigures the mode of the port from access to trunk

By sniffing the packets on the trunk it’s possible to determine the available VLAN IDs and the network ranges which are in use.

It is then possible to create a virtual interfaces and connect to each VLAN.
use the Linux command "vconfig" to create the interface eth1.100 that connects to VLAN ID 100 (Corporate Data VLAN).
Then an IP is assign IP or DHCP.

## vconfig
```
vconfig add eth1 100
dhclient -v eth1.100
ifconfig eth1.100
arp-scan --interface eth1.100 IP/CIDR
```

tags: #vlan #hopping #cdp #dtp #yesinia #vconfig 
