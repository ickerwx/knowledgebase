# Create an Access Point (AP) - Hotspot WiFi 3G 4G 5G - Shared Internet Connection
Reference https://bbs.archlinux.org/viewtopic.php?pid=1269258

# usb UMTS -> Laptop Hotspot <- Clients Connect
```
create_ap [options] <wifi-interface> [<interface-with-internet>] [<access-point-name> [<passphrase>]]
```

## WPA2 NATed
```
create_ap -w 2 -m nat wlan0 eth1 APNAMEfoobar Passwordfoobar
```

## Share Wifi and open AP on the same Wifi
```
create_ap -w 2 wlan0 wlan0 Test-AP password
```

tags: wifi ap hotspot [Access Point]
