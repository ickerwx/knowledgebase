# How to use backblaze b2 on Linux
 
 I am using `rclone` to do backups from FreeNAS to Backblaze B2. To sync files from the backup on Linux I use the same program.
 
 ## Setup
 
 Run `rclone config`, create a new config using API keys from backblaze. Then run the `config` command again, this time select `crypt` as the provider. Use the backblaze remote from before, provide key and salt from FreeNAS.
 
 ## Commands
 
 - `rclone listremotes` - list configured remote
 - `rclone ls <remotename>:<path>` - list content of path
 - `rclone copy <src> <dest>` - copy files, `src` and `dest` can both be local or remote

## Example config

I need several configs because I have unencrypted folder names that contain encrypted files. The `backblaze` in the sub-configs refers to the first config entry.

```ini
[backblaze]
type = b2
account = <snip>
key = <snip>

[b2dir1]
type = crypt
remote = backblaze:bucketname/unencryptedDirName1
filename_encryption = standard
directory_name_encryption = true
password = <snip>
password2 = <snip>

[b2dir2]
type = crypt
remote = backblaze:bucketname/unencryptedDirName2
filename_encryption = standard
directory_name_encryption = true
password = <snip>
password2 = <snip>
```

 
tags: #linux #backblaze_b2 #backup #cloud #storage #rclone #freenas 