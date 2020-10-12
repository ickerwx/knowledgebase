# run any linux application on a socket
```
mkfifo mypipe
nc -vv -l -s 127.0.0.1 -p 9026 < mypipe  | ./app > mypipe
```

## Endless loop
```
mkfifo mypipe
while true; do nc -vv -l -s 127.0.0.1 -p 9026 < mypipe  | ./app > mypipe ; done
```

tags: #socket #nc #mkfifo #pipe 
