Set-ExecutionPolicy -Force RemoteSigned
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
iwr https://chocolatey.org/install.ps1 | iex #Choco Install

#Azure VS2015 SDK - https://msdn.microsoft.com/library/mt695655.aspx
Invoke-WebRequest -Uri http://go.microsoft.com/fwlink/?LinkId=746481 -OutFile $env:TEMP\VWDOrVs2015AzurePack.exe
& $env:TEMP\VWDOrVs2015AzurePack.exe

#.NET CORE RC2 - https://www.microsoft.com/net/core#windows
Invoke-WebRequest -Uri https://go.microsoft.com/fwlink/?LinkId=798481 -OutFile $env:TEMP\DotNetCore.1.0.0.RC2-VS2015Tools.Preview1.exe
& $env:TEMP\DotNetCore.1.0.0.RC2-VS2015Tools.Preview1.exe /passive
