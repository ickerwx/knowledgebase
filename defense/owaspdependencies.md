# OWASP Dependency Check Maven Plugin

Add the following text as a new `<plugin>` between the `<plugins>` tags in the `pom.xml` file:

```xml
<plugin>
  <groupId>org.owasp</groupId>
  <artifactId>dependency-check-maven</artifactId>
  <executions>
	  <execution>
		  <goals>
			  <goal>check</goal>
		  </goals>
	  </execution>
  </executions>
</plugin>
```

Then run `mvn org.owasp:dependency-check-maven:check`. I had success using `mvn -X -U org.owasp:dependency-check-maven:check` (-X/-U flags added) when running into problems downloading dependencies. There will be a report html file `dependency-check-report.html` inside the `target/` subfolder.

tags: #owasp #devops #maven #java #defense #code_review