# Fixing Jython "sys-package-mgr: can't write cache file for and processing new jar" messages in Linux and Solaris

I know this is a nuisance for jython users, especially in Linux/Solaris environments if jython is installed as root in a common location where other users can invoke jython but can't cache jar files in their CLASSPATH in jython cachedir (in <JYTHON_HOME>/cachedir/packages) because of default permission problems for the jython cachedir directory, in fact the reason why I wanted to avoid these jar processing and error messages is because I use jython for automated testing and half of my test logs are filled with one or the other jar processing/error messages shown above, making it hard for debugging.

The obvious question is how can we avoid jython jar processing or error messages each time we invoke jython? Initially I didn't find a clear cut answer for this, obviously we need to set permissions accordingly, but which directory and how or is there a way we can change the jython registry settings to avoid this error, which is the best way, questions galore.

We will see two approaches as shown below to solve the jython jar processing messages/errors, one through setting the right permissions for jython cachedir directory and the other through modifying the jython registry settings, I have tested these in Solaris and Linux and of course the registry solution will also work for Windows.

1. Solving jython jar processing messages and errors by changing jython cachedir permissions
2. Solving jython jar processing messages and errors by changing jython registry settings
3. Solving jython jar processing messages and errors by changing jython cachedir permissions

As trivial it may sound but its not, for example assuming that the UNIX root user installed jython in the location /opt/jython and another UNIX user (jyuser in this example with home directory /export/home/jyuser) is trying to invoke jython with his own jars in the CLASSPATH (for this example I have included the JAR CLASSPATH of JDOM XML Parsing library as shown below), the error message which will be seen is
```
bash-3.00# su - jyuser
Sun Microsystems Inc. SunOS 5.10 Generic January 2005
-bash-3.00$ pwd
/export/home/jyuser
-bash-3.00$ echo $CLASSPATH
:/export/home/jyuser/jdom-1.1/lib/add_jdom_jars:/export/home/jyuser/jdom-1.1/lib/ant.jar:/export/home/jyuser/jdom-1.1/lib/jaxen-core.jar:/export/home/jyuser/jdom-1.1/lib/jaxen-jdom.jar:
/export/home/jyuser/jdom-1.1/lib/saxpath.jar:/export/home/jyuser/jdom-1.1/lib/xalan.jar:/export/home/jyuser/jdom-1.1/lib/xerces.jar:/export/home/jyuser/jdom-1.1/lib/xml-apis.jar:
-bash-3.00$ /opt/jython/jython
*sys-package-mgr*: processing new jar, '/export/home/jyuser/jdom-1.1/lib/ant.jar'
*sys-package-mgr*: can't write cache file for '/export/home/jyuser/jdom-1.1/lib/ant.jar'
*sys-package-mgr*: processing new jar, '/export/home/jyuser/jdom-1.1/lib/jaxen-core.jar'
*sys-package-mgr*: can't write cache file for '/export/home/jyuser/jdom-1.1/lib/jaxen-core.jar'
*sys-package-mgr*: processing new jar, '/export/home/jyuser/jdom-1.1/lib/jaxen-jdom.jar'
*sys-package-mgr*: can't write cache file for '/export/home/jyuser/jdom-1.1/lib/jaxen-jdom.jar'
*sys-package-mgr*: processing new jar, '/export/home/jyuser/jdom-1.1/lib/saxpath.jar'
*sys-package-mgr*: can't write cache file for '/export/home/jyuser/jdom-1.1/lib/saxpath.jar'
*sys-package-mgr*: processing new jar, '/export/home/jyuser/jdom-1.1/lib/xalan.jar'
*sys-package-mgr*: can't write cache file for '/export/home/jyuser/jdom-1.1/lib/xalan.jar'
*sys-package-mgr*: processing new jar, '/export/home/jyuser/jdom-1.1/lib/xerces.jar'
*sys-package-mgr*: can't write cache file for '/export/home/jyuser/jdom-1.1/lib/xerces.jar'
*sys-package-mgr*: processing new jar, '/export/home/jyuser/jdom-1.1/lib/xml-apis.jar'
*sys-package-mgr*: can't write cache file for '/export/home/jyuser/jdom-1.1/lib/xml-apis.jar'
*sys-package-mgr*: can't write index file
Jython 2.2.1 on java1.6.0_07
Type "copyright", "credits" or "license" for more information.
>>>
```
Remember jython caches jars in <JYTHON_HOME>/cachedir/packages (in our case /opt/jython/cachedir/packages), therefore I changed the permissions of /opt/jython/cachedir/packages (cachedir/packages) to 777 and tried the above command, the results are shown below.
```
-bash-3.00$ /opt/jython/jython
*sys-package-mgr*: processing new jar, '/export/home/jyuser/jdom-1.1/lib/ant.jar'
*sys-package-mgr*: processing new jar, '/export/home/jyuser/jdom-1.1/lib/jaxen-core.jar'
*sys-package-mgr*: processing new jar, '/export/home/jyuser/jdom-1.1/lib/jaxen-jdom.jar'
*sys-package-mgr*: processing new jar, '/export/home/jyuser/jdom-1.1/lib/saxpath.jar'
*sys-package-mgr*: processing new jar, '/export/home/jyuser/jdom-1.1/lib/xalan.jar'
*sys-package-mgr*: processing new jar, '/export/home/jyuser/jdom-1.1/lib/xerces.jar'
*sys-package-mgr*: processing new jar, '/export/home/jyuser/jdom-1.1/lib/xml-apis.jar'
*sys-package-mgr*: can't write index file
Jython 2.2.1 on java1.6.0_07
Type "copyright", "credits" or "license" for more information.
>>>
```
This solves the *sys-package-mgr*: can't write cache file error message, but still the *sys-package-mgr*: processing new jar message occurs everytime jython is invoked, after hacking around for sometime, finally the below chmod command did the trick for me.
```
chmod -R 777 <JYTHON_HOME>/cachedir/ chmod -R 777 (/opt/jython/cachedir/ in our case)

-bash-3.00$ /opt/jython/jython
Jython 2.2.1 on java1.6.0_07
Type "copyright", "credits" or "license" for more information.
>>>
```
Note that this will still process the jars the first time you invoke jython with thenew jars in the CLASSPATH, to avoid that execute <JYTHON_HOME>/jython > /dev/null 2>&1 and invoke jython again.

## Solving jython jar processing messages and errors by changing jython registry settings

There is another way to overcome jython jar processing and error messages by modifying jython registry settings in <JYTHON_HOME>/registry properties file,

Change the line
```
#python.cachedir.skip = false
```
to
```
python.cachedir.skip = true
```
In don't know the side effects of it as it was mentioned in the registry file above this property that it might break some java imports, if you don't want such unpleasant surprises, then go for the solution 1.

In a nutshell, to fix jython jar processing and error messages

1. Change the permissions which will allow all users to write to jython cachedir, chmod -R 777 /cachedir/
2. Set the the jython registry (<JYTHON_HOME>/registry) property python.cachedir.skip = true.

tags: #linux #java #python #jython 
