# Create a CA with openssl

## Create CA

```cheat openssl Create a CA key and certificate
openssl genrsa -out ca.key 4096
openssl req -new -x509 -key ca.key -out ca.crt
```

tags: #admin #linux #openssl 
