# Windows Tools

## VMs
We need a 32- and 64-Bit Windows VM for Exploit-Development, Win7 is usually working out better than Win10 for these as Windows10 changes a lot of stuff regulary.

## Must-Have
* PS2EXE https://gallery.technet.microsoft.com/PS2EXE-Convert-PowerShell-9e4e07f1
* IDA Pro
* Burp
* Immunity DBG
* OllyDBG
* Notepad++
* 7zip
* Firefox (+FoxyProxy,Cookiemanager)
* Git for Windows
* dnSpy
* Chrome
* OpenVPN for Windows
* Python2 + Python3
* Sublime Text
* Visual Studio 2017
* Pyinstaller
* PE-Explorer
* x64 Debug

## Mona
https://github.com/corelan/mona.git and place into immunity/PyCommands folder
`!mona config -set author xct`
`!mona config -set workingfolder c:\logs\%p`

## Python Packages
* virtualenvwrapper
* angr

tags: tools install windows