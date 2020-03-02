# MSI

## Tools
* http://wixtoolset.org/

## Creating MSI Files from Scratch
Get Wixtoolset. Create a XML-File that describes the installer from this temlate and save it as <name>.wxs:

```xml cheat wix wix template
<?xml version="1.0"?>
<Wix xmlns="http://schemas.microsoft.com/wix/2006/wi">
	<Product Id="*" UpgradeCode="8e2b6e8e-d8c0-4bdd-930e-5b7428ea9da6" Name="Example Product Name" Version="0.0.1" Manufacturer="xct" Language="1033">
	<Package InstallerVersion="200" Compressed="yes" Comments="Windows Installer Package"/>
	<Media Id="1" Cabinet="product.cab" EmbedCab="yes"/>
	<Directory Id="TARGETDIR" Name="SourceDir">
		<Directory Id="ProgramFilesFolder">
			<Directory Id="INSTALLLOCATION" Name="Example">
				<Component Id="ApplicationFiles" Guid="12345678-1234-1234-1234-123456789012">
					<File Id="ApplicationFile1" Source="<local file>"/>
				</Component>
			</Directory>
		</Directory>
	</Directory>
	<Feature Id="DefaultFeature" Level="1">
		<ComponentRef Id="ApplicationFiles"/>
	</Feature>
	<CustomAction Id="Shell" Directory="TARGETDIR" ExeCommand="<command>" Execute="deferred" Impersonate="yes" Return="ignore"/>
	<CustomAction Id="Fail" Execute="deferred" Script="vbscript" Return="check">
		Error
	</CustomAction>
	<InstallExecuteSequence>
	<Custom Action="Shell" After="InstallInitialize"></Custom>
	<Custom Action="Fail" Before="InstallFiles"></Custom>
	</InstallExecuteSequence>
	</Product>
</Wix>
```
```bash cheat wix compile .wixobj file
candle.exe <name>.wxs
```
```bash cheat wix generate .msi file with:
light.exe -out <name>.msi <name>.wixobj
```

Heat `heat.exe` can be used to scrape directories for files that you want to include in a installer.

## Backdoor MSI Files

With `dark.exe` from wixtools you can generate the wxs file from a given .msi file, e.g. `dark.exe <name>.msi <name>.wxs /x <outfolder>`

## Sign MSI Files

```bash cheat msi create cert from cacert and sign msi with it
C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin>makecert.exe -pe -n "CN=SPC" -a sha256 -cy end -sky signature -ic MyCA.cer -iv MyCA.pvk -sv spc.pvk spc.cer

pvk2pfx -pvk spc.pvk -spc spc.cer -pfx spc.pfx

C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin>signtool sign /f spc.pfx <name>.msi
```

tags: msi wix