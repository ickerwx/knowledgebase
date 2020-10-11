# Rescuing a linux system using a live CD

- check partitions, mount them. Be sure to check for LVM

```
mount /dev/sda2 /mnt
```

- check if you need to mount `/boot` under `/mnt/boot` as well

```
mount /dev/sda1 /mnt/boot
```

- mount virtual file systems

```
for i in proc sys dev; do mount --rbind /$i /mnt/$i ; done
```

- finally chroot into the mounted file system, do whatever needs to be done

```
chroot /mnt
```

tags: admin linux
