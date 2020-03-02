# Windows Privilege Escalation in Domains

## Bloodhound

Get all info there is about users, groups, login sessions,...

## Kerberoast

See Kerberoast.md

## DCSync

Some domain users have the privilege to use dcsync, usually domain admins but restricted to them.

### Meterpreter

Get hash of a user:
`dcsync_ntlm <username>` or dcsync `<username>`

## Golden Ticket

### Using the Golden Ticket

Having the ticket is not directly equal to domain admin or even local admin permissions. A way to utilize the ticket in filesystem is to access the domain controllers drive via UNC path:
`dir  \\DCNAME\C$`
Another way is to change user passwords via meterpreters `change_password` function.


## Other

SPNs are used by kerberos to associate service with logon account. The command `setspn -T <domain> -F -Q */*` gives information about services running on a domain controller, hostnames, ports, etc.


tags: windows [privilege escalation] domain
