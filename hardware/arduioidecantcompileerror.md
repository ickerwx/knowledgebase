# Arduino IDE kann nicht kompilieren (Arch + Blackarch)

Fehler ist irgendwas mit ```-lm not found``` oder so in der Art
```sh
cd /usr/share/arduino/hardware/tools/avr/bin
mv ./avr-gcc ./avr-gcc-backup
ln -s /usr/bin/avr-gcc ./
```
tags: hardware linux arduino