# Nicht-interaktive Shell zu interaktiver Shell machen
Mit netcat-Shell auf remote host:
```sh
python2 -c 'import pty; pty.spawn("/bin/sh")'
```
Danach lokal:
```sh
stty raw -echo
```
Neu mit netcat listener verbinden, reset mit ```reset``` oder Strg+L
Terminal (siehe ```$TERM```) eingeben
auf dem remote host anschließend ```$HOME```, ```$TERM``` und ```$SHELL``` exportieren, danach auf remote host:
```
stty rows XX cols YY
```
XX und YY bekommt man, indem man lokal ```stty -a``` ausführt
Ebenfalls möglich ist das Verwenden von ```expect```, falls installiert.
```
$ cat sh.exp
spawn sh
interact
```
Das Script wird auf dem Server mit ```expect exp.sh``` ausgeführt.

Alternativen:
```
echo os.system('/bin/bash')
```
oder
```
/bin/sh -i
```
Perl:
```
perl -e 'exec "/bin/sh";'
```
Lua:
```
os.execute('/bin/sh')
```
Von vi heraus:
```
:!bash
```
oder
```
:set shell=/bin/bash:shell
```

tags: pentest linux upgrade shell spawn
