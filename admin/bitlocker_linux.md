# Mounting a Bitlocker drive in Linux

1. Install program `dislocker` from repo
2. check the partition name of the encrypted partition using `gparted` or `fdisk -l`
3. `sudo dislocker /dev/partitionname1 -u -r -- /mount/point`
4. `sudo mount -o loop,user,users,uid=1234,gid=1234,ro /mount/point/dislocker-file /unencrypted/mount/point`

`dislocker` doesn't support using PIN + TPM, if that is what you have use `-p` instead of `-u` and provide the recovery key

tags: admin linux bitlocker
