# Jar-File bauen

```
$ jar -cfe Foo.jar Foo Foo.class
```

* ```-cfe```: create, filename, define entry point
* ```Foo.jar```: Dateiname des jar file
* ```Foo```: entry point, Klasse mit ```public static void main()```
* ```Foo.class [...]```: packe alle genannten Resourcen in das jar file

tags: Java