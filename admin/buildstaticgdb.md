# Statischen gdb bauen

[Quelltext](http://ftp.gnu.org/gnu/gdb/)

You can use the following options for configure script to generate a static GDB executable:

```
./configure --enable-static=yes && make && make install
```

tags: linux reversing