# PHP

## Common PHP-Vulnerabilities

* up to php 5.3: 'class_exists()' invokes '\__autoload'
* up to current: __new $controllerVar($controlledArg) can be exploited to Call SimpleXMLElement for XXE Attacks__
* __in_array without the 3rd parameter is not typesafe, therefore `in_array("5blabla",[3,4,5])` will be true__ (the string is type casted into int)
* bypass TWIG / PHPs FILTER_VALID_URL with javascript://comment%250aalert(1) possible
* __strpos gives false when needle is not found, but if its found at the beginning (pos 0), this is type cast to false__ also when used in a if construct
* *mail* function might be abused for rce (via log file tainting) if parameters are controlled https://blog.ripstech.com/2017/why-mail-is-dangerous-in-php/
* look for escapeshellargs escapeshellcmd that is done multiple times (that cancels each other out), also some functions internally use it so its not obvious in all cases
* missing escapes in regexes can lead to wrong filtering
* parse_str wíthout 2nd parameters registers query parameters as global variables..which might interfere with existing ones
* strtolower can have an eval modifier
* complex php expressions can be used to break out of stuff like {${phpinfo()}} or {$great->show}
* __str_replace is not beeing done recursivly__
* look for missing exit calls after redirects
* __htmlentities does not escape single quotes__
* on unserialize when the resulting thing is used as a string we can implement a special \_\_toString() method in our payload

## Fuzzing
* https://dl.packetstormsecurity.net/papers/general/PHP_Fuzzing_In_Action.pdf
* http://wapiti.sourceforge.net/ Web Application Fuzzer (opensource)
  - Installation https://sourceforge.net/p/wapiti/code/HEAD/tree/trunk/INSTALL.md
	```
	python -m venv wapiti3
	. ./wapiti3/bin/activate
	python3 setup.py install	
	```
###  Thaps Symbolic Execution Framework for PHP

#### Setup
* hg clone https://bitbucket.org/heinep/thaps
* apt install ...
* clone https://github.com/10gen/mongo-c-driver-legacy and make, make install (this needs a fix, see c section)

	
## Writing PHP Extensions

### General
* https://devzone.zend.com/303/extension-writing-part-i-introduction-to-php-and-zend/ for old php versions
* http://ahungry.com/blog/2016-09-29-Creating-a-php-7-extension.html for php 7
* there is a extension repo at pecl (https://pecl.php.net/), bit like pip for python, still have to add extension=name to php.ini

### Steps
* Download PHP
* cd to ext
* `./ext_skel --extname hello`
* phpize (in ext/<name>)
* `./configure --enable-hello`
* edit hello.c
* make
* symlink to your module in module folder (get with `php-config --extension-dir`) as `hello.so`
  - e.g. ` ln -s modules/hello.so /usr/lib/php/20151012/hello.so` (but use full path)
* verify its loaded with php -i | grep hello
* currently loaded php.ini file via `php -i|grep 'php.ini'`
* change enable_dl to true in php.ini if dynamic loading is disabled
* verify working with `php -f hello.php`

## Find tainted variables

### Taint Extension (https://github.com/laruence/taint)

* `sudo pecl pecl install taint`
* add to php.ini extension=taint
* add to bottom taint.enable = On and taint.error_level=2
* start server with php -S and look in console for tainted variables
* to run it in apache2 its the php.ini under apache folder.., might be good to point php logs to antoher file for this
* seems to fail sometimes.. (limesurvey does not work)

## Misc

### Downgrade
* Downgrade on Ubuntu 16.04 from 7.x to 5.6
```
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install php7.0 php5.6 php5.6-mysql php-gettext php5.6-mbstring php-mbstring php7.0-mbstring php-xdebug libapache2-mod-php5.6 libapache2-mod-php7.0
sudo update-alternatives --set php /usr/bin/php5.6
```

tags: php
