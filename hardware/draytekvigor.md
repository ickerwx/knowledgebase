# Draytek Firmware Reversing

## JTAG Pinout
oben rechts, direkt unter den UART Pins:
```
  /-----+
 1| X o | !rst
 3| X o | !rst
 5| X o | TDI
 7| X o | TMS
 9| X o | TCK
11| X o | TDO
  | o o |
  +-----+
      14
```
* Ergebnis von JTAGenum mit Arduino:
```
ntrst:pin1 tck:pin9 tms:pin7 tdo:pin11 tdi:pin5 IR length: 4
ntrst:pin3 tck:pin9 tms:pin7 tdo:pin11 tdi:pin5 IR length: 4
```
## Firmware Dump
* Verbindung mit OpenOCD hergestellt
* ```dump_memory rom 0x00000000 0x10000000``` ergibt Firmware Image in Datei ```rom```

tags: hardware jtag reversing