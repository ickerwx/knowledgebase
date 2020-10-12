# A tweet on common IoT vulnerabilities

the cybergibbons @cybergibbons

https://twitter.com/cybergibbons/status/931826171003723776
 
I'd like to tweet a series of findings that are typical for an embedded device, in ascending order of severity. This could be any device, but it's fairly typical for a Linux-based IoT product.

 - **Out-of-date CA bundle** - lots of devices have a CA bundle from 2012 or before. This means that many certs are out-of-date and there are some no longer trusted CAs. Developers will switch off cert validation as a result.
 - **Device lacks secure storage** - the SoC used by the device has no provision to securely store keys or confidential material. An attacker with physical access can recover keys, certificates, hashes, and passwords.
 - **Factory reset not correctly implemented** - either configuration (such as user's SSID/PSK), authentication information (certificates etc.) or data (stored videos) are not deleted or renewed when reset.
 - **Encryption implementation issues** - a custom protocol used by the device does not implement crypto correctly. Examples - encrypt without MAC, hardcoded IV, weak key generation.
 - **System not mimimised** - the system is running services and processes that aren't used. It's common to find a web UI running on a system, but undocumented and useless to consumers.
 - **Serial consoles enabled** - either raw serial or USB serial is enabled, allowing either the bootloader, a login prompt, or a unprotected shell to be accessed.
 - **WiFi connection process exposes SSID/PSK** - it's very common for devices to use a WiFi AP or BLE to allow the app to communicate the user's SSID/PSK for connection. Often in the plain. Attacker needs proximity physically.
 - **Firmware not signed** - this allows someone to create malicious firmware and deploy it to devices. Firmware not encrypted - this makes it much easier to examine firmware and find issues.
 - **Busybox not minimised** - busybox has been built with every single tool possible, providing a rich set of tools for an attacker to use.
 - **Root user allowed to login** - the root user either has no password, or a hardcoded password. Another vulnerability will allow them to login and use the system.
 - **Compile time hardening not used** - PIE/NX/ASLR/RELRO/Fortify haven't been used. They make exploiting buffer overflows harder.
 - **Unsafe functions used** - strcpy/sprintf/gets are used heavily in binaries found on the system. These are closely associated with buffer overflow-tastic systems.
 - **All processes run as root** - no principle of least privilege followed. Lots of devices could do this, but don't. No need to privesc when compromised.
 - **Device does not validate SSL certificates** - the HTTPS communications used by the device can be man-in-the-middled by an attacker. Can lead to serious compromise, especially if firmware updates delivered by this mechanism.

CONCLUSION: The device and system can't be immediately compromised. But in the event of another vulnerability being found, there is little stopping an attacker from totally owning the device.
Once again, the problem is adversarial research has conditioned vendors to ignore these level of findings. They aren't remote root access, not every device has been compromised. So often, these issues will not be fixed.
This is a real problem. The solution isn't pen-testing and remediation. The solution is secure development practices. All of these are known.

tags: #iot #hardware #links 
