# VBScript Snippets

### Base64 Decoder

```vbscript
Dim a,b
Set a=CreateObject("Msxml2.DOMDocument.3.0").CreateElement("base64")
a.dataType="bin.base64"
a.text="Base64-encoded String=="
Set b=CreateObject("ADODB.Stream")
b.Type=1
b.Open
b.Write a.nodeTypedValue
b.SaveToFile "foo.jar",2
```

tags: VBScript