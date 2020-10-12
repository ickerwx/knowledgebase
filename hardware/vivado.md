# Installing Vivado

- Account bei Xilinx erstellen, komische Exportkontrollgeschichte durchlaufen
  - fake adresse hat funktioniert
- Lizenz erstellen, dazu Code aus FPGA-Box eingeben und Vivado Design Suite, Design Edition auswählen
- Stand-Alone installer herunterladen (für 2019.2 waren das knapp 30GB)
- aus dem AUR installieren: xilinx-vivado-dummy digilent.adept.runtime digilent.adept.utilities
- tarball entpacken
- falls in tiling WM, in terminal: `export _JAVA_AWT_WM_NONREPARENTING=1`
- im entpackten Ordner als root `./xsetup ausführen`
  - Lizenz muss noch nicht hinzugefügt werden
- nach Installation startet der Dreck natürlich nicht, endet mit Fehlermeldung, dass libtinfo.so.5 nicht gefunden wurde
  - in `/usr/lib` als root ausführen: `ln -s libtinfo.so.6 libtinfo.so.5`
- in `$PATH` das folgende Script ablegen:

```sh
#!/bin/bash
unset LANG
unset QT_PLUGIN_PATH
source /opt/Xilinx/Vivado/2019.2/settings64.sh
/opt/Xilinx/Vivado/2019.2/bin/vivado
```

- dann mit `vivado` starten

## Vivado on Arch

steht im Wesentlichen alles [hier](https://wiki.archlinux.org/index.php/Xilinx_Vivado) beschrieben

tags: #hardware #fpga #xlinix #rene #linux #links 
