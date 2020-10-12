# Debugging Arch Linux

## Boot from Live-CD and chroot into installation

```
loadkeys de
fdisk -l
cryptsetup luksOpen /dev/sda3 rootvol
vgchange -a y
mount /dev/mapper/vg0-root /mnt 
mount /dev/sda2 /mnt/boot
mount /dev/sda1 /mnt/boot/efi
cd /mnt
mount -t proc proc proc/
mount -t sysfs sys sys/
mount -o bind /dev dev/
mkdir /mnt/hostlvm
mount --bind /run/lvm /mnt/hostlvm
chroot /mnt /bin/bash
ln -s /hostlvm /run/lvm
```

# Failed install
error: failed retrieving file 'xxxx.pkg.tar.xz' from some.mirror : Could not resolve host: some.mirror

`sudo pacman -Syu XXXX`

tags: #arch #debug #boot #install 
