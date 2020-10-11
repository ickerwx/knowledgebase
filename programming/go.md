# Working with go

## Go Basics

- `$GOPATH` determines where stuff is
  - it defaults to `$HOME/go`
- add `$GOPATH/bin` to `$PATH`
- check the path with `go env GOPATH`

## Snippets

```cheat go create window-/console-less application
go build -ldflags -H=windowsgui main.go
```

```cheat go Static linking
To force a Go binary to be statically linked set the CGO_ENABLED environment variable to 0:
export CGO_ENABLED=0
```

```cheat go Compile for Linux 32/64 bit
Specifying a 32/64 bit binary:
env GOARCH=386/amd64 go build
```

```cheat go Compile for Windows 32/64 bit
Specifying a 32/64 bit binary:
env GOOS=windows GOARCH=386/amd64 go build
```

```go cheat go Decoding a hex string
package main

import (
  "encoding/hex"
  "fmt"
)

func main() {
  h := "41424344"
  decoded, _ := hex.DecodeString(h)
  fmt.Println(decoded)
}
```

## Useful Links

- [Useful Go packages](https://www.golangprograms.com/go-programming-language-packages.html)

tags: programming go cheat snippets links
