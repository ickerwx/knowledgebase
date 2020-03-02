# Discovering Interesting Ports

This is a list of common ports that will give you a pretty good list of "alive" system when scanning internally or externally.

## TCP Discovery

 * FTP: 21
 * SSH: 22
 * Telnet: 23
 * SMTP: 25
 * Finger: 79
 * HTTP: 80
 * Kerberos: 88
 * POP3: 110
 * SUNRPC (Unix RPC): 111 (think: rpcinfo)
 * NetBIOS: 139
 * IMAP 143
 * LDAP: 389
 * HTTPS: 443
 * LotusNotes: 1352
 * Microsoft DS: 445
 * RSH: 514
 * CUPS: 631
 * NFS: 2049
 * Webrick(Ruby Webserver): 3000
 * RDP: 3389
 * Munin: 4949
 * SIP: 5060
 * PCAnywhere: 5631 (5632)
 * NRPE (-nix) /NSCLIENT++ (win): 5666 (evidence of Nagios server on network)
 * Alt-HTTP: 8080
 * Alt-HTTP tomcat: 9080
 * Another HTTP: 8000 (mezzanine in development mode for example)
 * Nessus HTTPS: 8834
 * Proxmox: 8006
 * Splunk: 8089 (also on 8000)
 * Alt HTTPS: 8443
 * vSphere: 9443
 * X11: 6000-6009 (+1 to portnum for additional displays) (see xspy, xwd, xkey for exploitation)
 * VNC: 5900, 5901+ (Same as X11; +1 to portnum for each user/dipslay over VNC. SPICE is usually in this range as well)
 * Printers: 9100, 515
 * Dropbox lansync: 17500


## UDP Discovery

 * DNS: 53
 * XDMCP: 177 (via NSE script --script broadcast-xdmcp-discover, discover nix boxes hosting X)
 * OpenVPN: 1194
 * MSSQL Ping: 1434
 * SUNRPC (Unix RPC): 111 (yeah, it's UDP, too)
 * SNMP 161
 * Network Time Protocol (NTP): 123
 * syslog : 514
 * UPNP: 1900
 * Isakmp - 500 (ike PSK Attack)
 * vxworks debug: 17185 (udp)


## Authentication Ports

 * Citrix: 1494
 * WinRM: 80,5985 (HTTP), 5986 (HTTPS)
 * VMware Server: 8200, 902, 9084
 * DameWare: 6129

## Easy-win Ports:

 * Java RMI - 1099, 1098
 * coldfusion default stand alone - 8500
 * IPMI UDP(623) (easy crack or auth bypass)
 * 6002, 7002 (sentinel license monitor (reverse dir traversal, sometimes as SYSTEM))
 * GlassFish: 4848
 * easy copy - `9060`
 * IBM Web Sphere: 9060
 * Webmin or BackupExec: 10000
 * memcached: 11211
 * DistCC: 3632
 * SAP Router: 3299

## Database Ports

 * easy copy - `3306,1521-1527,5432,5433,1433,3050,3351,1583,8471,9471`
 * MySQL: 3306
 * PostgreSQL: 5432
 * PostgreSQL 9.2: 5433
 * Oracle TNS Listener: 1521-1527
 * Oracle XDB: 2100
 * MSSQL: 1433
 * Firebird / Interbase: 3050
 * PervasiveSQL: 3351, 1583
 * DB2/AS400 8471, 9471
 * Sybase 5000

## NoSQL Ports

Reference: [Abusing NoSQL Def Con 21](references/DEFCON-21-Chow-Abusing-NoSQL-Databases.pdf)

 * easy copy - `27017,28017,27080,5984,900,9160,7474,6379,8098`
 * MongoDB: 27017,28017,27080
 * CouchDB: 5984
 * Hbase 9000
 * Cassandra:9160
 * Neo4j: 7474
 * Redis: 6379
 * Riak: 8098

## SCADA / ICS

source: http://www.digitalbond.com/tools/the-rack/control-system-port-list/ )

 * BACnet/IP: UDP/47808
 * DNP3: TCP/20000, UDP/20000
 * EtherCAT: UDP/34980
 * Ethernet/IP: TCP/44818, UDP/2222, UDP/44818
 * FL-net: UDP/55000 to 55003
 * Foundation Fieldbus HSETCP/1089 to 1091, UDP/1089 to 1091
 * ICCP: TCP/102
 * Modbus TCP: TCP/502
 * OPC UA Binary: Vendor Application Specific
 * OPC UA Discovery Server: TCP/4840
 * OPC UA XML: TCP/80, TCP/443
 * PROFINET: TCP/34962 to 34964, UDP/34962 to 34964
 * ROC PLus: TCP/UDP 4000

tags: ports tcp udp discovery recon links
