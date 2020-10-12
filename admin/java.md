# Java Snippets

### Write base64-encoded file to disk

```java
import java.io.FileOutputStream;
import java.util.Base64;
import java.util.Base64.Decoder;

class Foo {
    public static void main(String args[]){
        try{
            String b64file = "Base64-encoded File==";
            byte[] strenc = b64file.getBytes("UTF-8");
            
            //decoding byte array into base64
            Base64.Decoder dec= Base64.getDecoder();
            byte[] strdec=dec.decode(strenc);
            
            FileOutputStream fos = new FileOutputStream("/path/to/file.ext");
            fos.write(strdec);
            fos.close();
        }

        catch(Exception e){
            System.out.println(You broke it...");
        }
    }
}
```

tags: #java 
