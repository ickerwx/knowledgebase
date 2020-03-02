# Chuckle: Attacking unsigned SMB

https://www.nccgroup.trust/uk/about-us/newsroom-and-events/blogs/2015/november/introducing-chuckle-and-the-importance-of-smb-signing/

## Introducing Chuckle and the importance of SMB signing

Service Message Block (SMB) is a protocol used for accessing shared resources; most corporate Windows networks use SMB to access shared folders and printers. Digital signing is a feature of SMB designed to allow a recipient to confirm the authenticity of SMB packets and to prevent tampering during transit – this feature was first made available back in Windows NT 4.0 Service Pack 3. By default, only domain controllers require packets to be signed and this default behavior is usually seen in most corporate networks.

The issue with enabling signing for all hosts on a network is that doing so can impact performance, degrading network service by up to 15% [1]. Guides can be found all over the Internet [2] advising network administrators to disable signing in order to improve network performance. These caveats mean few administrators implement signing; leaving SMB traffic open to tampering.

SMB Relaying is an attack that exploits this weakness by modifying and relaying packets between a client and server in order to establish an authenticated connection. It is not a new issue; it was first documented by Sir Dystic in March 2001. Microsoft released a partial fix to prevent relaying an authentication request back to the originating host in 2008 (MS08-068), however SMB Relaying is still relevant today and can allow an attacker to escalate to domain administrator privilege on a fully patched modern Windows network.

Exploiting the issue requires a number of tools and techniques. Typically an attacker would first scan the network for SMB using Nmap. Nmap includes the smb-security-mode nse script which can identify the status of SMB signing on each host.

Once a target has been identified the attacker needs to attract an authentication request to their machine, relay the request to the target and if successful execute a payload. The attacker usually has system level access once exploited; allowing retrieval of plaintext passwords from memory, local password hashes and potentially sensitive documents stored on the machine. All this while being virtually transparent to the target.

When on a penetration test engagement with limited time, configuring and starting each tool to execute the attack (with their unique command line options) may be frustrating and potentially error prone under pressure. Out of this frustration I developed Chuckle, a script designed to help automate the process of SMB relaying and highlight the risk of not using SMB signing to a wider audience.
Chuckle works as a wrapper and requires the following tools:
* Nmap
* Responder
* SMBRelayx
* Veil-evasion
* Metasploit

Chuckle first scans the given network for hosts running SMB and presents a list of possible targets. Once the target is selected Chuckle asks which local IP and port to use for reverse connections then generates a payload using Veil-evasion, starts SMBRelayx and Responder then launches Metasploit’s payload handler. Once the payload handler has started you can simply wait, on a busy network you will often gain a shell after only a short while.

Source code for chuckle can be found here:  https://github.com/nccgroup/chuckle

In conclusion, despite being the default setting, disabling SMB signing can lead to the complete compromise of your network even when all hosts are fully patched. Consideration should be made as to whether SMB signing can be practically enabled as this will likely be an enterprise-wide change. Implementation without disruption may be difficult due to compatibility issues with legacy devices and increased overhead.

[1] https://technet.microsoft.com/en-us/library/cc731957.aspx
[2] https://redmondmag.com/articles/2014/05/16/network-performance-problems.aspx

tags: windows pentest smb tools