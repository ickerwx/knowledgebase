# Notes on using Sonarqube
## Example project config
Create a config file, `sonar-project.properties`, place it in the source code root directory.
```
# must be unique in a given SonarQube instance
sonar.projectKey=THIS-SHOULD-BE-UNIQUE
# this is the name and version displayed in the SonarQube UI. Was mandatory prior to SonarQube 6.1.
sonar.projectName=PROJECTNAMEHERE
sonar.projectVersion=1.0

# Path is relative to the sonar-project.properties file. Replace "\" by "/" on Windows.
# This property is optional if sonar.modules is set.
sonar.sources=.
sonar.host.url=http://IP.ADDR.OF.SERVER:PORT/sonar
# Encoding of the source code. Default is default system encoding
#sonar.sourceEncoding=UTF-8
sonar.login=GENERATE USING THE WEB INTERFACE
```

## Run scan using local scanner instance
Change into the project root dir, then run
```
c:\Path\to\sonar-scanner-3.0.3.778-windows\bin\sonar-scanner.bat
```
Haven't used in on linux, will probably work the same

tags: #source_code_audit #pentest #sonarqube 
