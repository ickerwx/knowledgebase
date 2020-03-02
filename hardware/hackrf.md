# HackRF

## USB Auto-Suspend für HackRF deaktivieren

HackRF kann nicht mit dem Auto-Suspend umgehen, kann bei TLP deaktiviert werden in der Datei ```/etc/default/tlp```

```
USB_BLACKLIST="1d50:cc15 1d50:6089"
```
Die erste VID:PID gehört glaube ich zum rad1o, die zweite ist das HackRF

tags: hardware hackrf linux