# IP Forwarding
```
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT
iptables -A FORWARD -j ACCEPT
```

tags: forwarding [ip forwarding]
