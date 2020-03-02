# Oracle Database

## Read Files via Oracle sql
```sql
declare
  f utl_file.file_type;
  s varchar(200);
begin
  f := utl_file.fopen('/inetpub/wwwroot', 'iistart.htm', 'R');
  utl_file.get_line(f,s);
  utl_file.flose(f);
  dbms_output.put_line(s);
end;
```

## Write files via Oracle 

```sql
declare
  f utl_file.file_type;
  s varchar(5000) := 'hello world';
begin
  f := utl_file.fopen('/inetpub/wwwroot', 'helloworld.txt', 'W');
  utl_file.put_line(f,s);
  utl_file.flose(f);
end;

```

tags: oracle read upload ippsec silo
