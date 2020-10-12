# Portknocking
## Single Packet Portknocking
```
fwknop -A tcp/22 -R -D linux.org --key-gen --use-hmac --save-rc-stanza
```

## Client

To use it on the client side we can do:
```cheat portknocking portknocking example
for i in port1 port2 port3; do nmap -Pn --host_timeout 201 --max-retries 0 -p $i <rhost>; done
```

tags: #portknocking 
