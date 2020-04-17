# Using Yubikey as smartcard in Chrome on Linux

- install `nss` package, `# pacman -S nss`
- run this command:

```sh cheat modutil Add yubikey to NSS database
cd
modutil -dbdir sql:.pki/nssdb -add "bdr yubikey" -libfile /usr/lib/opensc-pkcs11.so
```

```sh cheat modutil List keys in NSS database
modutil -dbdir sql:.pki/nssdb -list
```

tags: admin yubikey modutil smartcard linux cheat
