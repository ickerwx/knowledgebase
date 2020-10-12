# Windows Domain Enumeration

## Bypassing Constrained Language Mode

Try starting `powershell` like this:
```
powershell -version 2
```

## Get Domain Info

```powershell cheat Get Domain Info
[System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
```

## Find Users and Filter

```powershell cheat Find and filter users
get-aduser -filter 'passwordneverexpires -eq "true" -and enables -eq "true"' | select samaccountname
```

tags: #windows #pentest #recon #enumeration 
