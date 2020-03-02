# Python snippets

## TiddlyWiki image encoder

Nutzung: ```./encoder.py file.jpg```

Bild base64-kodieren
auf der Webseite kann man den img-Tag gleich kopieren und in "<html>"-Tags packen
ansonsten  '<html><img height="$1px" src="data:image/png;base64,iVBO...== /></html>'
den kompletten String in neuen Tiddler packen, mit Tag [[Pictures]] versehen
einfügen in Ziel-Tiddler mit """<<tiddler "Name des Tiddlers" with: heightvalue>>"""
```python
import sys
import base64

prefix = '<html><img width="$1px" src="data:image/'
suffix = '" /></html>'

if len(sys.argv) != 2:
    print "%s <filename>" % sys.argv[0]
    sys.exit(1)

data = open(sys.argv[1], "rb").read()
print prefix + sys.argv[1].rsplit('.', 1)[1] + ';base64,' + base64.b64encode(data) + suffix
```

## Debugging
```
python2 -m pdb <program> <arg1> <arg2>
import pdb; pdb.set_trace()
```

## Iterate through object attributes

for attr, value in vars(k).items():
    print(attr, '=', value)

tags: python snippets
