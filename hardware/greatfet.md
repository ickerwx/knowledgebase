# Working with the GreatFET One

## Setup and installation

- detailled write-up [here](https://greatscottgadgets.github.io/greatfet-tutorials/getting-started.html)

- install host software using pip3
  - `sudo pip3 install --upgrade greatfet`

- install udev rules
```sh
sudo wget https://raw.githubusercontent.com/greatscottgadgets/greatfet/master/host/misc/54-greatfet.rules -O /etc/udev/rules.d/54-greatfet.rules
sudo udevadm control --reload-rules
```

- connect, then run `greatfet info` to check status; the device might take a few seconds before the GF One is found

```
greatfet info
Found a GreatFET One!
  Board ID: 0
  Firmware version: 2018.12.1
  Part ID: xxxxxxxxxx
  Serial number: xxxxxxxxxxxxxxx
```

- update to latest firmware with `greatfet fw --auto`

### Problems with a new device

If you have problems running the client and `greatfet info` returns a stack trace and `usb.core.USBError: [Errno 5] Input/Output Error`, then try this:

```
greatfet info; greatfet fw --auto
```

The first call will fail, but the second command works. There's a [github issue](https://github.com/greatscottgadgets/greatfet/issues/248) that mentions this workaround. After flashing the new firmware, the bug should be gone:

```
greatfet info
Found a GreatFET One!
  Board ID: 0
  Firmware version: v2020.1.2
  Part ID: xxxxxxxxxxxx
  Serial number: xxxxxxxxxxxxxxxxxxx
```

tags: #greatfet_one #hardware #usb #links #rene 
