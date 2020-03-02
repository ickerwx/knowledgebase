#HTTP 

## Directory Enumeration
```
gobuster -u http://$ip:8080 -w /usr/share/dirb/wordlists/common.txt -s '200,204,301,302,403,500' -e
dirb http://$ip /usr/share/dirb/wordlists/common.txt
```

## Wordpress scan
```
wpscan --url https://$ip:12380/blogblog/ --enumerate u --disable-tls-checks
```


```
wpscan --url https://$ip:12380/blogblog/ -P /usr/share/wordlists/rockyou.txt -U john --disable-tls-checks
```

## DNS Zone-Transfer TCP 53
```
host -t axfr domain.com 10.10.x.dns
```

## DNS subdomains
```
wfuzz -H 'Host: FUZZ.example.com' -u https://10.10.10.10 -w /usr/share/seclists/Discovery/DNS/shubs-subdomains.txt --hw 28
```

##Hydra http-post-form Brute force

```cheat hydra HTTP POST brute force
hydra 10.11.x.x -s 80 http-form-post "/wp/wp-login.php:log=^USER^&pwd=^PASS^&wp-submit=Log+In&testcookie=1:S=Location" -L usernames.txt -P passwortliste.txt
```

## HTTP Methods
```cheat nmap Test HTTP methods
nmap -p 8585 -sV –script http-methods,http-trace –script-args http-methods.test-all=true,http-methods.url-path=’/uploads/’ 192.168.2.66
```


tags: http gobuster dirb web friendzone
