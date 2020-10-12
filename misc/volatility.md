# volatility to get information out of RAM image dumps 

## following command to get for example for infos --> get profile for next step
```cheat volatility Get basic information
volatility -f xx.dmp imageinfo
```

## get hashdump from that imagedump

```cheat volatility Get hashdump from image dump
volatility -f xxx.dmp --profile Win2012R2x64 hashdump
```

tags: #ram #dump #volatility #ippsec #silo #christian 
