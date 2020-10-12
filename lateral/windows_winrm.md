# Windows Remoting

## General

WinRM is a way to access windows boxes via powershell remotely and is usually running on Ports 5985/5986.

The Library (ruby) to go for doing winrm from linux boxes is https://github.com/WinRb/WinRM. You can do all kinds of fancy stuff with it, including certificate based winrm authentication with the following script:

```
require 'winrm'

# Author: Alamot

conn = WinRM::Connection.new( 
  endpoint: 'https://<ip>:5986/wsman',
  transport: :ssl,
    :client_cert => 'certs/certnew.cer',
    :client_key => 'certs/private.key',
    :no_ssl_peer_verification => true
)

command=""

conn.shell(:powershell) do |shell|
    until command == "exit\n" do
        output = shell.run("-join($id,'PS ',$(whoami),'@',$env:computername,' ',$((gi $pwd).Name),'> ')")
        print(output.output.chomp)
        command = gets        
        output = shell.run(command) do |stdout, stderr|
            STDOUT.print stdout
            STDERR.print stderr
        end
    end
    puts "Exiting with code #{output.exitcode}"
```

There is also python versions with `community/python-pywinrm 0.3.0-2` and `community/python2-pywinrm 0.3.0-2`

tags: #winrm 
