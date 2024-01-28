# Bitwarden

## Start/Stop

```
./bitwarden.sh start|stop
```

## Config Changes

Modify ./bwdata/config.yml, then run:

```
./bitwarden.sh rebuild
```

## Update

```
./bitwarden.sh update       # update containers and DB
./bitwarden.sh updateself   # update main script
./bitwarden.sh updatedb     # update/initialize DB
```

## Administration

Open `$BITWARDENURL/admin`, then follow the link in the mail.

## Backup

Inside `./bwdata/` are various assets:

```
./bwdata/mssql/data
./bwdata/core/attachments
./bwdata/env
```

Bitwarden creates nightly backups and keeps them for 30 days. The are in `./bwdata/mssql/backups`.

## bitwarden-rofi

Sometimes bitwarden-rofi gives the error "Could not load items". This can be fixed by running

```cheat bitwarden Fix load items error
keyctl purge user bw_session
```


tags: #linux #bitwarden #admin #passwords 
