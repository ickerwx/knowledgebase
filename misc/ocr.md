# OCR get text from image (e.g. screenshot from video)

## convert png to jpg for ocr  need Imagemagick installed for /usr/bin/convert
```bash
convert -colorspace gray -fill white  -resize 480%  -sharpen 0x1 in.png out.jpg
```


```bash 
tesseract hashes.jpg hashes
```


tags: ocr tesseract christian
