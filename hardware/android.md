# Flashing images to Android

- Download image file from wherever
  - unzip it

```cheat fastboot Flash Android images manually
adb reboot fastboot
fastboot devices -l
fastboot flash boot boot.img
fastboot flash bootloader bootloader.img
fastboot reboot-bootloader
fastboot flash radio radio.img
fastboot flash recovery recovery.img
fastboot flash system system.img
fastboot flash vendor vendor.img
fastboot reboot
```

tags: #hardware #rene #android #fastboot #cheat 
