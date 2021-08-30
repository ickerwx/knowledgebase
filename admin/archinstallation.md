# Installing Arch Linux

```sh
timedatectl set-ntp true
fdisk -l # get available disks
fdisk /dev/device # delete existing partions, create 1 EFI partition, remaining storage one big LUKS partition
mkfs.fat -F32 /dev/efipartition # format efi partition
cryptsetup luksFormat /dev/devicepartition
cryptsetup open /dev/devicepartition cryptlvm
pvcreate /dev/mapper/cryptlvm # create physical volume on mapped device
vgcreate lvmvg /dev/mapper/cryptlvm # create volume group named lvmvg
lvcreate -L 32G lvmvg -n swap # swap volume
lvcreate -l 100%FREE lvmvg -n root # create root volume with remaining space
mkfs.ext4 /dev/lvmvg/root
mkswap /dev/lvmvg/swap
swapon /dev/lvmvg/swap
mount /dev/lvmvg/root /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
pacstrap /mnt base linux linux-firmware vim intel-ucode
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
vim /etc/locale.gen # uncomment desired locales
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo LC_TIME=de_DE.UTF-8 >> /etc/locale.conf
echo hostname > /etc/hostname # also add hostname to /etc/hosts
efibootmgr --disk /dev/nvme0n1 --part 1 --create --label "Arch Linux" --loader /vmlinuz-linux --unicode 'cryptdevice=UUID=50f042a1-f251-4214-a52b-41e4f3cfd802:cryptlvm root=/dev/lvmvg/root resume=/dev/lvmvg/swap rw initrd=\initramfs-linux.img' --verbose
```

tags: #linux/arch #admin
