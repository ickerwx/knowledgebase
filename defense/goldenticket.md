# What is a golden ticket and how does it work?

## Really, what is it?

- method to generate ticket-granting tickets for any user
  - allows impersonation of any account, even non-existing
- can be created offline

- need NT hash of KRBTGT account
  - hash is the Kerberos secret key

- krbtgt account is used to encrypt and sign all Kerberos tickets for a domain
- krbtgt is the Kerberos security principal

- read-only DCs have their own individual krbtgt account password

## Containment

- reset password or the krbtgt account **TWICE**
  - the reason for this is that, if the decryption of the ticket failed (because the pw has been changed once), the system will try former hashes
  - if the AD password history group policy is not set to the default 2, then you either need to reset the password *n* times, or delete the whole history

## Impact

- session tickets become invalid an need to be reissued again
- services and application that require manual password input need to be restarted

## Detection

- Windows does not distinguish a legitimate TGT from a golden ticket, there is no universal rule to detect the use of a golden ticket
- event ID 4769 with status code 0x1f indicates a failed attempt with a golden ticket after the double reset

## References

- [EU Cert on golden tickets](http://cert.europa.eu/static/WhitePapers/CERT-EU-SWP_14_07_PassTheGolden_Ticket_v1_1.pdf)

- [MS on pass the hash](http://download.microsoft.com/download/7/7/A/77ABC5BD-8320-41AF-863C-6ECFB10CB4B9/Mitigating%20Pass-the-Hash%20(PtH)%20Attacks%20and%20Other%20Credential%20Theft%20Techniques_English.pdf)


tags: #windows #pentest #redteam #mimikatz #links 
