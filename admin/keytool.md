# Working with keytool

```cheat keytool List keys in a keystore
keytool -keystore foo.jks -list
```

```cheat keytool Extract cert from keystore
## extract X509 in DER format
keytool -keystore foo.jks -exportcert -alias "alias shown with -list" -file foo.der

## extract X509 in PEM format
keytool -keystore foo.jks -exportcert -alias "alias shown with -list" -file foo.pem -rfc
```

```cheat keytool Extract cert and private key from keystore, store as pkcs12
keytool -importkeystore -srckeystore foo.jks -srcalias "alias shown with -list" -destkeystore foo.p12 -deststoretype pkcs12
```

```cheat keytool Import certificate into keystore
keytool -importcert -file cert.pem -keystore keystore.jks -alias "something"
```

tags: admin cheat keytool
