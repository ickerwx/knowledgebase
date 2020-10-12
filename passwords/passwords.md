# Password Cracking

## Setup
If Windows is the Host-OS use hashcat for windows to crack passwords. Even without a dedicated GPU its magnitutes faster.


## crack keepass db
```
keepass2john database.kdbx > database.hash
john --wordlist=/usr/share/wordlists/rockyou.txt database.hash


## Wordlists
* http://acacha.org/~sergi/wordlists/dirbuster/
* https://github.com/danielmiessler/SecLists
* https://wiki.skullsecurity.org/Passwords

## Archives
For ".zip":
`fcrackzip -v -D -u -p <wordlist> <target>.zip`

For other types:
TODO (Add script here)

Best way is usually to use some variant of `<type>2john`, these scripts extract hashes we can use with john or hashcat which is a lot faster then using the actuall unzip tools themself.

## Mutate wordlists manually
Add specific file ending to a wordlist:
`sed -i "s|$|.<ending>|" <file>` (maybe dos2unix before)
Mutate with John:
`john ---wordlist=<input list> --rules --stdout > <output list>`


## Hashcat
E.g. `hashcat64.exe -m 10900 hashes.txt rockyou.txt`, to see the required format for  hash use `hashcat64.exe -m <number> --example-hashes`. If hashes are in format `<username>:<password>` add `--username` to the command.

##Cracking shadow file
```cheat hashcat crackin shadow files
hashcat -m 7400 shadow_hash /usr/share/wordlist/rockyou.txt
msfadmin:$1$XN10Zj2c$Rt/zzCW3mLtUWA.ihZjA5/:14684:0:99999:7:::
**$1$XN10Zj2c$Rt/zzCW3mLtUWA.ihZjA5/**
```


##Cracking shadow file with john and unshadow
```cheat bash unshadow
unshadow passwd-file.txt shadow-file.txt > unshadowed.txt
john --rules --wordlist=/usr/share/wordlists/rockyou.txt unshadowed.txt
```

## Hydra
E.g. ` `
Be carefull to set the destination port with `-s`.
As Fail condition you can set :<string>, or you can set :S=302 if you want to count redirection as success. 
```cheat
hydra -l root -p admin 192.168.1.105 -t 4 ssh
hydra -L user.txt -P passwords.txt 192.168.1.105 ssh
```
tags: #passwords #crackings #hydra #hashcat #john 
