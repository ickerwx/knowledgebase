# iptables

## NAT

Enable ip forwarding:
`sysctl net.ipv4.ip_forward = 1`
NAT traffic from eth2 (incoming) to eth2 (outgoing) and let answer packets through the firewall.

```bash cheat iptables enable nat
iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE
iptables -A FORWARD -i eth2 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth1 -o eth2 -j ACCEPT
```

## Drop by Port
iptables -A INPUT -j DROP -p tcp --destination-port 902

## Save Current rules - will be loaded by systemd on boot
iptables-save > /etc/iptables/iptables.rules

## Restore them manualy
iptables-restore < /etc/iptables/iptables.rules


tags: iptables
