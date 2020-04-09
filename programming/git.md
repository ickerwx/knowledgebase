# Git usage notes

## Basic usage
```sh
git pull
git add -A
git status
git commit
git log
git push
```

## Removing a submodule from a repository
```sh cheat git Remove submodule from repository
# Remove config entries:
git config -f .git/config --remove-section submodule.$submodulename
git config -f .gitmodules --remove-section submodule.$submodulename

# Remove directory from index:
git rm --cached $submodulepath

# Commit

# Delete unused files:
rm -rf $submodulepath
rm -rf .git/modules/$submodulename

**no leading or trailing slashes in `$submodulepath`**
```

## Reset master to origin/master

```sh cheat git Reset master to origin/master
git reset --hard origin/master
```

## Update submodules

```sh cheat git Update submodules
git submodule update --remote --recursive
```

## Find first commit of file

```sh cheat git Find first commit of filename
git log -1 --reverse --pretty=oneline filename
```

## Add SSL Cert authentication to git

First create a folder `certs` and move certificate, key and ca cert there. Then:

```sh cheat git add SSL cert authentication
git config --local http.sslCAInfo certs/ca.crt
git config --local http.sslCert certs/cert.crt
git config --local http.sslKey certs/key.pem
git config --local http.sslVerify false or maybe don't do that
```

tags: programming git cheat
