# C/C++

## Building
Most projects can be build with:
```
libtoolize --force
aclocal
autoheader
automake --force-missing --add-missing
autoconf
./configure
```

## Static Compilation with cmake
For static compilation with cmake use cmake-gui and disable shared library building.

tags: c