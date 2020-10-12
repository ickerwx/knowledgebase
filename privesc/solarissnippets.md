# Nützliche Solaris-Snippets

## Vollständiges Prozesslisting
```
/usr/ucb/ps -alxww
/usr/ucb/ps -alxww
pargs /proc/*
```
## Offene Dateien/Handles
```
pfiles `ls /proc` | less
```
## Welcher Prozess hat welchen Port auf?
```sh
#!/bin/ksh

line='---------------------------------------------'
pids=$(/usr/bin/ps -ef -o pid=)

for f in $pids
do
/usr/proc/bin/pfiles $f 2>/dev/null | /usr/xpg4/bin/grep -q "port:"
if [ $? -eq 0 ]; then
echo $line
# pargs -l $f
/usr/bin/ps -o pid,args -p $f
fi
done
exit 0
```
## Installierte Pakete und Software
```
pkginfo -l
showrev -a
```
## Zoneninfo
```
zoneadm list -vi
```
## Firewall-Status
```
ipfstat -io
ipf -V
```
## World-writable Files
```
find / \( -fstype nfs -o -fstype cachefs -o -fstype autofs -o -fstype ctfs -o -fstype mntfs -o -fstype objfs -o -fstype proc \) -prune -o -type f \( -perm -4000 -o -perm -2000 \) -exec ls -l {} \;
```
## SUID/SGID-Files
```
find / \( -fstype nfs -o -fstype cachefs -o -fstype autofs -o -fstype ctfs -o -fstype mntfs -o -fstype objfs -o -fstype proc \) -prune -o -type f \( -perm -4000 -o -perm -2000 \) -exec ls -l {} \;
```
## stderr redirection
Es muss beim redirecten von stderr darauf geachtet werden, dass die Umleitung in eine Datei vor der Umleitung von stderr auf stdout erfolgt.
```
./foobar1 2>&1 >file
```
funktioniert nicht, stderr geht noch immer ins Terminal.
```
./foobar >file1 2>&1
```
so geht's. Grund ist, dass wenn die redirection für 2 ausgewertet wird, zeigt 1 noch immer auf's Terminal und wird erst danach umgeleitet. Im zweiten Fall ist das nicht so, hier wird zuerst 1 umgeleitet, danach 2 dahin, wo 1 jetzt hinzeigt.

tags: #vulnerability_assessment #pentest #solaris #snippets 
