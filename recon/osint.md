# Osint

## Shodan (https://shodan.io)
* dorks: title: , html: , product: , banner: , net:

## Censys.io (https://censys.io)
* subdomain finder: https://github.com/christophetd/censys-subdomain-finder

## SSLScrape (https://github.com/cheetz/sslScrape)
Uses masscan on a network to discover webports and scrapes certificates for information.
```
python ./sslScrape.py <ip/range>
```

## Discover (https://github.com/leebaird/discover)
Uses ARIN, Dnsrecon, goofile, goog-mail, goohost, theHarvester, Metasploit, URLCrazy, Whois, multiple websites, recon-ng.
It does most things which are needed in osint.
```
./update.sh
./discover.sh
<Domain>
<Passive>
<Company>
<DomainName>
```

## Emails
Look for email adresses used. Crossover with past breaches.

### SimplyEmail ()
Finds all email adresses for a company.
```
./SimplyEmail.py -all -v -e <url>
firefox <url>/Email_List.html
```

## Github Enumeration

### TruffleHog (https://github.com/dxa4481/truffleHog.git)
Searches github commit histories and branches for secrets/keys and prints them.
```
python truffleHog.py <targetrepo>
```

### GitAllSecrets (https://github.com/anshumanbh/git-all-secrets)
Uses TruffleHog and repo-supervisor on an organization. Its a bit complicated to setup though and needs a github access token (to use github api).
```
docker run -ti abhartiya/tools_gitallsecrets:v3 - repoURL=<url> -token=<github access token> -output <results.txt> 
```

## S3Bucket Enumeration

### Slurp (https://github.com/bbb31/slurp)
```
./slurp domain -t <targets>
./slurp keyword -t <targets>
```

### BucketFinder (https://digi.ninja/files/bucket_finder_1.1.tar.bz2)
Looks for different buckets and downloads all content for analysis.
```
./bucket_finder.rb --region us my_words --download
```

tags: #osint #github #bucket #shodan #censys 
