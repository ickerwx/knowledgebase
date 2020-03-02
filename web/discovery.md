# Discovery

## Folder & File Enumeration
Gobuster vs http://<ip>/ with (Seclists/Discovery/Web-Content/*, use any of the rafter*.txt files). Note that gobuster does not work recursivly - you have to search every new folder by hand.
Examples:
```cheat gobuster recon directory 
gobuster -u http://x.x.x.x:8080 -w /usr/share/dirb/wordlists/common.txt -s '200,204,301,302,403,500' -e
```

Dirb can be used aswell but is slower than gobuster and doesnt support custom wordlists.
`TODO Commands`

Do the enumeration using `wfuzz`:
```cheat wfuzz Basic resource discovery
wfuzz -H "Host: HOSTNAMEHERE --hc=404,302 -w /usr/share/wordlists/whatever https://hostname/FUZZ"
```

## Subdomain Enumeration

### Wfuzz
Wfuzz can find subdomains effectivly(Seclists/Discovery/DNS). It's important to set the Host-Header here.
`TODO Command`

### knockpy (https://github.com/guelfoweb/knock.git)
Enumerates subdomain by wordlists.

### sublist3r (https://github.com/Plazmaz/Sublist3r)
Uses google dorks for subdomain enumeration.

### subrute (https://github.com/TheRook/subbrute)
Uses open resolvers as a kind of proxy to circumvent DNS rate-limiting and does not send queries directly to the target.

## Parameter Fuzzing
Wfuzz can be used to fuzz Parameters or really any part of the Request aswell. For Parameters there are also special Lists included with Seclists.
`wfuzz -b <cookie> -w <wordlist>(e.g. SecLists burp-parameter-names) <url>?FUZZ=/something`
You can filter out unwanted responses with various switches e.g. `--hc 400 --hs '^[0-9]+$'` hides all answers with response code 400 and hides all responses whose contents match the specified regex.

## Screenshots

### httpscreenshot (https://github.com/breenmachine/httpscreenshot)
Combines massscan with phantomjs screenshot taking.
```
nano networks.txt (iprange)
./masshttp.sh
firefox clusters.html
``` 

### EyeWitness (https://github.com/ChrisTruncer/EyeWitness)
Takes nmap scan as input, makes screenshots on web ports and generate a nice report.
```
python ./EyeWitness.py -x scan.xml --web
```

### Xshot
`TODO`

tags: web discovery xct
