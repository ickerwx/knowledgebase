# Parameters to build shellcode for easy challenges

```c
char main[] = { /* shellcode here  */ }
```

```
-std=c99 so we can use gets()
-z norelro so we can overwrite GOT entries
-z execstack to put shellcode on the stack
-fno-pie so our exe doesn't get relocated
-no-stack-protector so we don't get stack cookies
Run with setarch x86_64 -R so we disable ASLR
```

tags: programming exploitation shellcode linux
