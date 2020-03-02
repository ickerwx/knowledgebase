# Lateral Movement - Linux Snippets

## Portscanning

This snippet scans all ports without the need of any additional tool
`for p in {1..65535}; do echo hi > /dev/tcp/<targt ip>/$p && echo port $p is open > scan 2>/dev/null; done`

Using netcat:
`netcat -v -z -n -w <ip> <port> 2>&1`

## Mysql non-interactive

Example:
`mysql -u <user> -p'<password>' -D DATABASENAME -e "UPDATE `database` SET `field1` = '1' WHERE `id` = 1111;" > output.txt`

tags: lateral linux