# Liste alle aufgerufenen Funktionen in IDA

Listet alle von der aktuell betrachteten Funktion aus aufgerufenen Funktionen auf
```python
from idautils import *

ea = ScreenEA()
for f in Functions(SegStart(ea), SegEnd(ea)):
    print "%s (0x%x)" % (GetFunctionName(f), f)
```
tags: reversing [ida pro] python snippets