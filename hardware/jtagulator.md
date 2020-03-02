# Working with the JTAGulator

## Updating firmware

- Download zip from [Github repo](https://github.com/grandideastudio/jtagulator/releases)
- Download Propeller tool for Windows from [the CPU manufacturer](https://www.parallax.com/downloads/propeller-tool-software-windows-spin-assembly) and install it
- unzip firmware, inside Propeller tool load .eeprom file and flash

## Usage notes

- using firmware version 1.6

```
> U

UART> H
UART Commands:
U   Identify UART pinout
T   Identify UART pinout (TXD only)
P   UART passthrough

General Commands:
V   Set target I/O voltage (1.2V to 3.3V)
H   Display available commands
M   Return to main menu

UART> U
UART pin naming is from the target's perspective.
Enter text string to output (prefix with \x for hex) [CR]: testtest
Enter starting channel [0]:
Enter ending channel [0]: 7
Possible permutations: 56

Ignore non-printable characters? [Y/n]: y
Press spacebar to begin (any other key to abort)...
JTAGulating! Press any key to abort...
--------------------------------------------------------
No target device(s) found!
UART scan complete.

UART> M
> j
JTAG> h
JTAG Commands:
I   Identify JTAG pinout (IDCODE Scan)
B   Identify JTAG pinout (BYPASS Scan)
D   Get Device ID(s)
T   Test BYPASS (TDI to TDO)
Y   Instruction/Data Register (IR/DR) discovery
X   Transfer instruction/data
C   Set JTAG clock speed
  
General Commands:
V   Set target I/O voltage (1.2V to 3.3V)
H   Display available commands
M   Return to main menu
  
JTAG> d
TDI not needed to retrieve Device ID.
Enter TDO pin [0]:
Enter TCK pin [0]:
Enter TMS pin [0]:
Pin numbers must be unique!
  
JTAG> i
Enter starting channel [0]:
Enter ending channel [7]:
Possible permutations: 336
  
Bring channels LOW between each permutation? [y/N]:
Press spacebar to begin (any other key to abort)...
JTAGulating! Press any key to abort...
  
TDI: N/A
TDO: 1
TCK: 3
TMS: 4
Device ID #1: 1111 1100001100000000 00000011011 1 (0xFC300037)
TRST#: 2
TRST#: 6
  
  
TDI: N/A
TDO: 1
TCK: 6
TMS: 4
Device ID #1: 1111 1100001100000000 00000011011 1 (0xFC300037)
TRST#: 2
TRST#: 3
--
TDI: N/A
TDO: 6
TCK: 0
TMS: 3
Device ID #1: 0000 0000000000000000 00000000001 1 (0x00000003)
Device ID #2: 0000 0000000000000000 00000011111 1 (0x0000003F)
Device ID #5: 0000 0000000000000000 00000011111 1 (0x0000003F)
Device ID #7: 0000 0000000000000000 00000001111 1 (0x0000001F)
Device ID #11: 0000 0000000011111111 11111111111 1 (0x000FFFFF)
Device ID #14: 0000 0000000001111111 11111111111 1 (0x0007FFFF)
Device ID #21: 0000 0000000000000000 00000000000 1 (0x00000001)
Device ID #23: 0000 0111111111111111 11111111111 1 (0x07FFFFFF)
TRST#: 1
TRST#: 2
TRST#: 4
TRST#: 5
TRST#: 7
  
- 
IDCODE scan complete.

JTAG> B
Enter starting channel [0]: 0
Enter ending channel [7]: 7
Are any pins already known? [y/N]: y
Enter X for any unknown pin.
Enter TDI pin [2]:
Enter TDO pin [1]:
Enter TCK pin [6]: X
Enter TMS pin [4]: X
Possible permutations: 30
  
Bring channels LOW between each permutation? [y/N]: y
Enter length of time for channels to remain LOW (in ms, 1 - 1000) [100]:
Enter length of time after channels return HIGH before proceeding (in ms, 1 - 1000) [100]:
Press spacebar to begin (any other key to abort)...
JTAGulating! Press any key to abort...
------
TDI: 2
TDO: 1
TCK: 3
TMS: 4
TRST#: 6
Number of devices detected: 1
----------------
TDI: 2
TDO: 1
TCK: 6
TMS: 4
TRST#: 3
Number of devices detected: 1
--------
BYPASS scan complete.

JTAG> D
TDI not needed to retrieve Device ID.
Enter TDO pin [1]:
Enter TCK pin [6]:
Enter TMS pin [4]:
  
Device ID #1: 1111 1100001100000000 00000011011 1 (0xFC300037)
-> Manufacturer ID: 0x01B
-> Part Number: 0xC300
-> Version: 0xF
IDCODE listing complete.
  
JTAG> D
TDI not needed to retrieve Device ID.
Enter TDO pin [1]:
Enter TCK pin [6]: 3
Enter TMS pin [4]: 4
  
Device ID #1: 1111 1100001100000000 00000011011 1 (0xFC300037)
-> Manufacturer ID: 0x01B
-> Part Number: 0xC300
-> Version: 0xF
IDCODE listing complete.
  
JTAG>
``` 

tags: hardware jtag jtagulator links rene
