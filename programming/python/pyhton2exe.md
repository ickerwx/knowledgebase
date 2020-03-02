# Create an W32 executalbe exe from a python script
## Example Project Patator - PyInstaller Bundling on Windows 5.2.3790 x86
```bash cheat windows python exe
Install `python-2.7.9.msi` from [Python](https://www.python.org/downloads/windows/).
Install `pywin32-219.win32-py2.7.exe` from [PyWin32](http://sourceforge.net/projects/pywin32/files/pywin32/).
Install `vcredist_x86.exe` from [Microsoft](http://www.microsoft.com/en-us/download/confirmation.aspx?id=29).
Install `Git-1.9.5.exe` from [Git](http://git-scm.com/download/win) (and select "Use Git from Windows Command Prompt" during install).
Add `c:\Python27;c:\Python27\Scripts` to your `PATH`.

pip install pycrypto pyopenssl
pip install impacket
pip install paramiko
pip install IPy
pip install dnspython

cd c:\
git clone https://github.com/lanjelot/patator
git clone https://github.com/pyinstaller/pyinstaller
cd pyinstaller
git checkout a2b0617251ebe70412f6e3573f00a49ce08b7b32 # fixes this issue: https://groups.google.com/forum/#!topic/pyinstaller/6xD75_w4F-c
python pyinstaller.py --clean --onefile c:\patator\patator.py
patator\dist\patator.exe -h
```

The resulting stand-alone `patator.exe` executable was confirmed to run successfully on Windows 2003 (5.2.3790), Windows 7 (6.1.7600), Windows 2008 R2 SP1 (6.1.7601) and Windows 2012 R2 (6.3.9600).

tags: python exe
