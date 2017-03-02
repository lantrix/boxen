Set-ExecutionPolicy -Force RemoteSigned
iwr https://chocolatey.org/install.ps1 | iex #Choco Install

#.NET CORE 1.0.1 - https://www.microsoft.com/net/core#windowsvs2015
Invoke-WebRequest -Uri https://go.microsoft.com/fwlink/?LinkID=827546 -OutFile $env:TEMP\DotNetCore.1.0.0-VS2015Tools.Preview2.exe
& $env:TEMP\DotNetCore.1.0.0-VS2015Tools.Preview2.exe /passive

#Azure Azure SDK 2.9 for .NET (VS2015) - https://azure.microsoft.com/en-us/blog/announcing-visual-studio-azure-tools-and-sdk-2-9/
Invoke-WebRequest -Uri http://go.microsoft.com/fwlink/?LinkId=746481 -OutFile $env:TEMP\VWDOrVs2015AzurePack.exe
& $env:TEMP\VWDOrVs2015AzurePack.exe
