# Mount a Windows vhd image on linux

## following command for mounting image
```cheat guestmout Mount an image
guestmount --add image.vhd --inspector --ro /mnt/image
```


## dumping passwords from image
```
cd /Windows/System32/config

samdump2 SYSTEM SAM
User:1000:aad3b435b5ll1404eeaad3b435b51404ee:2611201357d963c8dc4217daec986d9:::

crack 
```


tags: wget ftp linux
