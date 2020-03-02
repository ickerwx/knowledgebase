# Working with the Black Magic Probe

## Using gdb

```
( 1) $ arm-none-eabi-gdb
( 2) [...]
( 3) (gdb) target extended-remote /dev/ttyACM0
( 4) Remote debugging using /dev/ttyACM0
( 5) (gdb) monitor tpwr enable
( 6) (gdb) monitor jtag_scan|swdp_scan
( 7) [Liste mit gefundenen targets]
( 8) (gdb) attach n
( 9) (gdb) set mem inaccessible-by-default off
(10) (gdb) dump binary memory <file> <start> <stop>
```

( 1) starte arm gdb auf dem Rechner

( 3) nutze BMP für debugging

( 5) wenn Vtarget voltage nicht verbunden ist, nutze internen voltage translator

( 6) scanne nach targets entweder mit JTAG oder SWD

( 8) attache an das target mit der Nummer n

( 9) mache memory außerhalb der bekannten memory map des Prozesses erreichbar (bspw. für memory mapped IO)

(10) erstelle einen memory dump

tags: hardware [black magic probe] rene
