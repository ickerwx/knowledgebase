# VMware auto resizing

das Problem mit dem nicht mehr funktionierenden Resizen der Auflösung bei der Kali-VM konnte gelöst werden. Folgender Eintrag in der VMX-Datei der VM hat gefehlt:

```svga.autodetect = "TRUE"```

tags: vmware admin