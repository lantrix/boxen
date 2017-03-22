Set-ExecutionPolicy -Force RemoteSigned
iwr https://chocolatey.org/install.ps1 | iex #Choco Install

#Azure Azure SDK 2.9.6 for .NET (VS2015) - https://www.microsoft.com/en-us/download/details.aspx?id=54289
Invoke-WebRequest -Uri https://aka.ms/azuresdk2015_296 -OutFile $env:TEMP\VWDOrVs2015AzurePack.2E2.2E9.exe
& $env:TEMP\VWDOrVs2015AzurePack.2E2.2E9.exe
