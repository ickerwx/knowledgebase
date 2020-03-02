# Misc

## tmux
* tmux ls, tmux a -t <id>, ^+d for detach

## create image with dd and mount
* `lsusb`
* `fdisk -l`
* `dd if=/dev/sdb of=<name> bs=1M`
* `mount -o ro,loop,offset={start*block_width} harddrive.img /mnt/loop`

## rdp
xfreerdp /u:<user> /v:<ip> +clipboard


## tcpdump

```bash cheat tcpdump capture to file and to stdout
 tcpdump -vvv -s0 -i any -w - | <fname>.pcap | tcpdump -r -
```

## Activate Windows XP for 30 days
Boot into SafeMode and run `rundll32.exe syssetup,SetupOobeBnk` to get 30 days activation

tags: tmux rdp misc