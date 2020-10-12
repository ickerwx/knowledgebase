# Systemd timer usage

## Run knowledgebase tag updater as systemd timer

Place the following two files into `~/.config/systemd/user/`

* create_knowledgebase_tags.service

```ini
[Unit]
Description=Update tag files

[Service]
type=oneshot
ExecStart=/home/rene/code/knowledgebase/scripts/createtaglist
WorkingDirectory=/home/rene/code/knowledgebase

[Install]
WantedBy=default.target
```

* create_knowledgebase_tags.service

```ini
[Unit]
Description=Run knowledgebase tag update service

[Timer]
OnCalendar=*:0/10
persistent=false
unit=create_knowledgebase_tags.service

[Install]
WantedBy=timers.target
```

## Automatically delete undo file

I use vim's `undotree` plugin and want to delete undo files older than a week.

- create `delete_undofiles.service`

```ini
[Unit]
Description=Delete undo files older than seven days

[Service]
type=oneshot
ExecStart=find ~/.vim/undodir -mtime +7 -delete
WorkingDirectory=/home/rene/.vim/undodir

[Install]
WantedBy=default.target
```

- create `delete_undofiles.timer`

```ini
[Unit]
Description=Run delete_undofiles.service

[Timer]
OnCalendar=daily
persistent=false
unit=delete_undofiles.service

[Install]
WantedBy=timers.target
```

- enable using `systemctl --user enable delete_undofiles.timer` and `systemctl --user start delete_undofiles.timer`

tags: #linux #admin #systemd #rene #vim 
