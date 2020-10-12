# Proxmark3 notes

## Unbricking using JTAG
Looks like an Iceman firmware update I flashed broke the bootloader. To fix it:

|Proxmark3|Bus Pirate|
|-----    | ----- |
|TMS	|CS	|
|TDI	|MOSI|
|TDO	|MISO|
|TCK	|CLK|
|GND	|GND|
|3.3	|+3.3|

In terminal 1
```
$ openocd -f tools/at91sam7s512-buspirate.cfg
Open On-Chip Debugger 0.10.0
Licensed under GNU GPL v2
For bug reports, read
  http://openocd.org/doc/doxygen/bugs.html
  Warn : Adapter driver 'buspirate' did not declare which transports it allows; assuming legacy JTAG-only
  Info : only one transport option; autoselect 'jtag'
  adapter speed: 1000 kHz
[...]
```
In terminal 2
```
$ telnet localhost 4444
Connected to localhost.
Escape character is '^]'.
Open On-Chip Debugger

>
> halt
> flash erase_sector 0 0 15
erased sectors 0 through 15 on flash bank 0 in 0.351705s
> flash write_image ./armsrc/obj/fullimage.elf
wrote 190924 bytes from file ./armsrc/obj/fullimage.elf in 281.332581s (0.663 KiB/s)
> flash write_image ./bootrom/obj/bootrom.elf
wrote 3776 bytes from file ./bootrom/obj/bootrom.elf in 6.327095s (0.583 KiB/s)
>
```

See also
- https://joanbono.github.io/PoC/Flashing_Proxmark3.html
- https://github.com/Proxmark/proxmark3/wiki/Debricking-Proxmark3-with-buspirate

### OpenOCD config for the buspirate
```
# Ports
telnet_port 4444
gdb_port 3333

# Interface
interface buspirate
buspirate_port /dev/ttyUSB0
adapter_khz 1000

# Communication speed
buspirate_speed normal # or fast

# Voltage regulator: enabled = 1 or disabled = 0
buspirate_vreg 1

# Pin mode: normal or open-drain
buspirate_mode normal

# Pull-up state: enabled = 1 or disabled = 0
buspirate_pullup 1

# use combined on interfaces or targets that can't set TRST/SRST separately
reset_config srst_only srst_pulls_trst

jtag newtap sam7x cpu -irlen 4 -ircapture 0x1 -irmask 0xf -expected-id 0x3f0f0f0f

target create sam7x.cpu arm7tdmi -endian little -chain-position sam7x.cpu

sam7x.cpu configure -event reset-init {
    soft_reset_halt
    mww 0xfffffd00 0xa5000004   # RSTC_CR: Reset peripherals
    mww 0xfffffd44 0x00008000   # WDT_MR: disable watchdog
    mww 0xfffffd08 0xa5000001   # RSTC_MR enable user reset
    mww 0xfffffc20 0x00005001   # CKGR_MOR : enable the main oscillator
    sleep 10
    mww 0xfffffc2c 0x000b1c02   # CKGR_PLLR: 16MHz * 12/2 = 96MHz
    sleep 10
    mww 0xfffffc30 0x00000007   # PMC_MCKR : MCK = PLL / 2 = 48 MHz
    sleep 10
    mww 0xffffff60 0x00480100   # MC_FMR: flash mode (FWS=1,FMCN=72)
    sleep 100

}

gdb_memory_map enable
#gdb_breakpoint_override hard
#armv4_5 core_state arm

sam7x.cpu configure -work-area-virt 0 -work-area-phys 0x00200000 -work-area-size 0x10000 -work-area-backup 0
flash bank sam7x512.flash.0 at91sam7 0 0 0 0 sam7x.cpu 0 0 0 0 0 0 0 18432
flash bank sam7x512.flash.1 at91sam7 0 0 0 0 sam7x.cpu 1 0 0 0 0 0 0 18432
```

tags: #hardware #rfid #proxmark3 #jtag #openocd #links #buspirate 
