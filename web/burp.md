# Working with Burp Suite

## Importing Burp certificate into a Java jks keystore
- export certificate from Burp, will be in `der` format
  - optional: convert to PKCS7: `openssl x509 -inform der -in certificate.cer -out certificate.pem`
- import into keystore: `keytool -importcert -file certificate.cer -keystore keystore.jks -alias "Alias"`

## Stop Firefox from checking for captive portals
Firefox tries to detect captive portals by requesting success.txt from detectportal.firefox.com. This heavily clutters the HTTP history in Burp.
To disable the captive portal detection:
- open `about:config`
- set `network.captive-portal-service.enabled` to `false`

## Proxy Java applications through Burp
- pass `-Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=8080` as options to `java`

## Remove URL Encoding
- Ctrl+Shift+U

## Quirks
When changing from GET to POST do it through BURPs context Menu - doing it manually can and will break things.

Also some websites really dont like burp and the only way to talk properly to them is to disable it.

tags: pentest Burpsuite java openssl webapp firefox
