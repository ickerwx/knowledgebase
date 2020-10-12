# Working with SSH

## Connecting to old SSH Servers

If you connect to an SSH server and the key exchange fails b/c the client does not support the older algorithms of the server, you do this:

```
➜ ssh manage@$HOST -vv
<snip>
debug2: peer server KEXINIT proposal
debug2: KEX algorithms: diffie-hellman-group-exchange-sha1,diffie-hellman-group1-sha1
debug2: host key algorithms: ssh-rsa,ssh-dss
<snip>
ssh_dispatch_run_fatal: Connection to $HOST port 22: DH GEX group out of range
```

You can see that the server supports `diffie-hellman-group-exchange-sha1,diffie-hellman-group1-sha1` for the key exchange. Use this by adding `-o KexAlgorithms=diffie-hellman-group1-sha1` to the command line:

```
ssh manage@$HOST -o KexAlgorithms=diffie-hellman-group1-sha1
manage@$HOST's password:
```

## SSH magic key sequence

The openSSH client knows a magic key sequence that allows you to interact with the session. Press enter at the prompt, followed by the `~` (tilde) key.
```
rene at maskelyne in ~
$ ~?
Supported escape sequences:
 ~.   - terminate connection (and any multiplexed sessions)
 ~B   - send a BREAK to the remote system
 ~C   - open a command line
 ~R   - request rekey
 ~V/v - decrease/increase verbosity (LogLevel)
 ~^Z  - suspend ssh
 ~#   - list forwarded connections
 ~&   - background ssh (when waiting for connections to terminate)
 ~?   - this message
 ~~   - send the escape character by typing it twice
(Note that escapes are only recognized immediately after newline.)
```
Use `~C` to add port forwarding in the existing session.

## SSHFS / SFTP
Mount with `sshfs -P <port> user@ip <local destination folder>`

## Convert Putty-Key to SSH-Key
`puttygen puttykey.ppk -O private-openssh -o opensshkey`

## SSH and VMware
I had the problem that whenever I was using `ssh` from a VMware VM, the connection would terminate immediately with `packet_write_wait: Connection to $host port $port: Broken pipe`.

This can be fixed by starting `ssh` like this:

```sh cheat ssh Avoid broken pipe error in VMware
ssh -o IPQoS=throughput ...
```

# ssh reverse tunnel example for tech support
## add user account on jumphost
```
root@jumphost:~# useradd support1
root@jumphost:~# passwd support1
```

## send login and host data to external supporter
  TO: supporter@external-support.com
  MSG: we meet us here:   ssh support1@jumphost.internet.com
  TODO: start this comand: screen -S support1

## go and pickup the waiting supporter at jumphost
```
 me@blackhole:~$ ssh -R 2222:localhost:22 support1@jumphost.internet.com
 # PW: think
 support1@jumphost:~$ screen -ls # list all screen sessions
 support1@jumphost:~$ screen -x support1 # pick up the supporter (shared screen)
 support1@jumphost:~$ ssh -p2222 me@localhost # take you and supporter back to blackhole (by reverse tunnel)
 me@blackhole:~$ ssh admin@crapy
```

## when work ist done: close the tunnel. if you are not sure, do this:
```
root@jumphost:~# usermod -L support1 # lock the account
root@jumphost:~# pkill -9 -u support1 # be sure all sessions are killed
```

tags: #windows #linux #admin #ssh #pentest #putty #vmware 
