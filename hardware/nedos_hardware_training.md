# Hardware Hacking Training

- 14.-18.10.19

## Tag 1 (14.10.19)

- auf den Folien hat er recommended reading, ganz am Anfang
- Verilog ist VHDL überlegen lt. nedos
- empfiehlt sehr das CMOS VLSI Buch am Ende des Abschnitts
- zuerst hat er ein paar Schaltungen vorgestellt
  - Halb-/Volladdierer
  - D-Flip-Flop
  - Shift Register
  - Debouncer
- aus KV-Diagrammen FPGA synthetisieren wurde kurz (eine Slide) angerissen
- moderne Plattformen
  - ASIC
  - CPLD
  - FPGA
- Tenor bisher ist: die Toolchain ist kacke, jeder Hersteller von FPGAs hat seine eigene Toolchain, die alle Kacke sind, und alles auf der Welt läuft mit diesem Code
  - nobody reads the warnings...
- es gibt ein Verilog-Makro, mit dem verhindert werden kann, dass bei einem Vertipper eine neue Variable angelegt wird. Nicht jeder Compiler respektiert dieses Makro...
- Smart Cards:
  - GND in der Mitte rausschneiden
  - Laser Scanning Microscope macht direkt Bilder aller Schichten
    - haben wir sowas in der Entwicklung?
  - den Bildern kann man Seriennummern auf dem Die entnehmen, die man suchen kann (Stichwort Common Criteria Dokumentation)

### Übung 1

- baue den Schaltkreis für einen Halbaddierer und daraus einen Volladdierer

### Übung 2

- baue eine Schaltung, die:
  - 1 ausgibt (oder das Eingangssignal?)
  - die Schaltung bekommt ein rst Signal (rst=1)
  - wenn rst gesetzt ist, gib für vier Clock Zyklen eine 0 aus

### erste Übungen zu VHDL

- siehe Hardware Hacking Spickzettel

## Tag 2 (15.10.19)

- in I2C oder SPI triggert das Clock-Signal die Shift Registers des Slave

## unrelated

- ipad/surface laptops sind ganz cool zum arbeiten in der Präsentation, aber man mus sich was einfallen lassen, damit der dongle nicht die ganze Zeit aus der Buchse fällt

tags: hardware training rene
