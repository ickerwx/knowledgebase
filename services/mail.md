# Mail Protocols

## POP3 (110)

### Manual Connection to SSL/POP3
`openssl s_client -connect <ip>:<port>`, when connecting to windows targets (e.g. Exchange) use `-clrf` switch.

### Commands
* USER
* PASS
* LIST

## IMAP
https://busylog.net/telnet-imap-commands-note/
`openssl s_client -connect <ip>:993` (-crlf on Windows)

### Commands
Login:
`a login <username>@<domain> <password>`
List Mailboxes:
`a LIST "" "*"`
Select Mailbox:
`a SELECT <mailboxname>`
Search Messages:
`a UID SEARCH ALL`
Read Message(s):
`a UID FETCH <ID> (BODY[1.1])`
`BODY.PEEK[]`
`UID FETCH <uid> (BODY[1])`

tags: mail pop3 openssl imap pentest admin
