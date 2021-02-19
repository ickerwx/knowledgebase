# SMB 

## enumeration SMB
```cheat grab userlist
enum4linux $ip -U
```

./nullinux.py -shares  10.10.10.123



```
/nullinux.py -users  10.10.10.123
```

```
smbclient //10.10.10.123/general -U ""%"" -c "get creds.txt"
```

```cheat grab userlist
smbclient -N -L $ip
```

```cheat smb vuln scan
nmap --script smb-vuln*.nse
```

## mount smb share
```
sudo apt-get install cifs-utils
mount -t cifs //10.10.10.134/Backups -o user=guest,password= /mnt/backups
```

## automount cifs share using /etc/fstab and systemd

Append the following text to the mount options in `/etc/fstab`:

```
,x-systemd.automount,x-systemd.requires=network-online.target
```

tags: #christian #smb #linux 
