# Working with go

## Go Basics

- `$GOPATH` determines where stuff is
  - it defaults to `$HOME/go`
- add `$GOPATH/bin` to `$PATH`
- check the path with `go env GOPATH`

## install latest go on ubuntu

sudo add-apt-repository ppa:gophers/archive
sudo apt-get update
sudo apt-get install golang-1.10-go
sudo ln -s /usr/lib/go-1.10/bin/go /usr/bin/go

## create window-/console-less application

go build -ldflags -H=windowsgui main.go

## Static linking

To force a Go binary to be statically linked set the CGO_ENABLED environment variable to 0:

```
export CGO_ENABLED=0
```

## Compile for Linux 32/64 bit

Specifying a 32/64 bit binary:

```
env GOARCH=386/amd64 go build
```

## Compile for Windows 32/64 bit

Specifying a 32/64 bit binary:

```
env GOOS=windows GOARCH=386/amd64 go build
```

tags: programming go
