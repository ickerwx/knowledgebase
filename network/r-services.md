# R*-Services aka Berkeley Remote ("r") Commands
```
rlogin -i fakedLocUser -l targetUser -p 513 host
rsh -l bin host csh -i  #  untested!!
use auxiliary/scanner/rservices/rlogin_login # metasploit

~/.rhosts  (~/.rlogin)
user host # strict config
+ +  # everyone can conntect from * # echo "+ +" > ~/.rhosts

/etc/hosts.equiv
```

tags: R-Service remote [Berkeley Remote]
