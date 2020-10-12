# Egress Firewall Test - to find unfiltered TCP Ports

## on the exfil Server
```
iptables -A INPUT -p tcp -m state --state new -j LOG --log-prefix "EgressTest:"
journalctl -k | grep "EgressTest.*"
iptables -F # to clean up lateron
```

## on the Client aka the Firewall
```
EXFILL="127.0.0.1";rm ./donetcat ;for e in {0..65536};do echo "sleep 0.1; echo 'PORT-$e';nc $EXFILL $e &" >> donetcat ; done ; bash ./donetcat
```

tags: #egress #firewall 
