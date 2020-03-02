# Metasploit

## Installation

### Archlinux

I would recommend to install the blackarch repos:

```bash
# Run https://blackarch.org/strap.sh as root and follow the instructions.
$ curl -O https://blackarch.org/strap.sh

# The SHA1 sum should match: 9f770789df3b7803105e5fbc19212889674cd503 strap.sh
$ sha1sum strap.sh

# Set execute bit
$ chmod +x strap.sh

# Run strap.sh
$ sudo ./strap.sh
```

After this you can create metasploit and postgresql:

```bash
$ sudo pacman -S blackarch/msfdb blackarch/metasploit postgresql
```

You can use the blackarch init script now:

```bash
$ sudo msfdb-blackarch init
```

This will create the database. After that you can start the database and run metasploit in user mode:

```bash
$ sudo msfdb-blackarch start
$ msfconsole -q
```

or you can start and run the metasploit as root:

```bash
$ sudo msfdb-blackarch run
```
tags: admin linux metasploit
