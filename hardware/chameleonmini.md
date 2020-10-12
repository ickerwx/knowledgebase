# Working with the Chameleon Mini RevG

## Firmware update
```sh
$ git clone https://github.com/emsec/ChameleonMini.git chamini
$ cd chamini/Firmware/Chameleon-Mini/
$ make
# now hold RBTN, then plug in Chameleon Mini
$ sudo make program
```

## Usage
- Connect using screen or socat
  - `sudo screen /dev/ttyACM0 115200`
    - TODO: find out how to enable local echo in screen
  - ` sudo socat - /dev/ttyACM0,crnl`
    - socat echoes input by default
- create config with `minicom`
  - run `sudo minicom -s`
  - set up serial port, check Serial Device
  - save setup as `some_name`, quit
  - from now on run `sudo minicom some_name`
  - Ctrl-A E for local echo
    - TODO: can that be set as default somehow?

- basic queries:
```
version?
config?
config=?
setting?

config=iso14443a_reader
identify
101:OK WITH TEXT
Unknown card type.
ATQA:	0400
UID:	0C0FFFE0
SAK:	28

config=MF_CLASSIC_1K
rbutton=uid_random
lbutton=recall_mem
uid=0c0fee0
```

### Sniffing reader communication

```
CONFIG=ISO14443A_SNIFF
LOGMODE=MEMORY
LOGCLEAR
RBUTTON=CYCLE_SETTINGS
LBUTTON=STORE_LOG
LOGDOWNLOAD
```

The above will switch the chameleon into reader mode, tell it to store the log in memory, then clear the current log. `RBUTTON` will cycle through the settings slots, `LBUTTON` will move the log from SRAM to permanent memory. `LOGDOWNLOAD` will download the log...

tags: #chameleon_mini #hardware #rfid 
