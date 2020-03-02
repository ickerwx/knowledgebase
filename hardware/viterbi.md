# Viterbi Notes

Bought a kit for the Viterbi keyboard from [Keeb.io](https://keeb.io).

## Flashing the Pro Micro

When flashing for the first time, you need to flash the EEPROM. From inside the QMK root directory: 

- reset the Pro Micro by shorting `RST` and `GND`
- then quickly run this command

```
avrdude -c avr109 -p m32u4 -P /dev/ttyACM0 -U eeprom:w:'./keyboards/nyquist/eeprom-lefthand.eep':a
```

flash the right hand file for the right half as well. Then you can compile and flash the firmware.

## Compiling and flashing QMK

```sh
# inside the QMK root dir
make viterbi:default:avrdude
```

### Error while flashing

I got an error from avrdude:

```
avrdude: ERROR: address 0x800519 out of range at line 1756 of <snip>
```

The reason for this seems to be avr-gcc. The current version was `avr-gcc-8.2.0-1-x86_64`. After downgrading to `avr-gcc-8.1.0-1-x86_64` the error disappeared.

tags: hardware qmk keyboards [pro micro] arduino avr viterbi avrdude
