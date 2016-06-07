Set-ExecutionPolicy -Force RemoteSigned
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
iwr https://chocolatey.org/install.ps1 | iex #Choco Install

#Sublime packages
Write-Host "Press any key once Sublime synced via Dropbox ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Write-Host "Setup Sublime settings"
$pControlDir="$($env:HOME)\AppData\Roaming\Sublime Text 3\Installed Packages"
$pControlFile="Package Control.sublime-package"
$pControl="https://packagecontrol.io/Package%20Control.sublime-package"
Invoke-WebRequest -Uri $pControl -OutFile (Join-Path -Path $pControlDir -ChildPath $pControlFile)
$SUBLIME_SYNC_DIR="$env:HOME\Dropbox\syncdata\Sublime\User"
$SUBLIME_USER_DIR="$env:appdata\Sublime Text 3\Packages\User"
Remove-Item -Path $SUBLIME_USER_DIR -Recurse -Force
New-Item -ItemType SymbolicLink -Path $SUBLIME_USER_DIR -Value $SUBLIME_SYNC_DIR

#Patch VS2015 - https://msdn.microsoft.com/library/mt695655.aspx
Invoke-WebRequest -Uri http://go.microsoft.com/fwlink/?LinkID=780690 -OutFile $env:TEMP\vs14-kb3151378.exe
& $env:TEMP\vs14-kb3151378.exe /Passive

#Azure VS2015 SDK - https://msdn.microsoft.com/library/mt695655.aspx
Invoke-WebRequest -Uri http://go.microsoft.com/fwlink/?LinkId=746481 -OutFile $env:TEMP\VWDOrVs2015AzurePack.exe
& $env:TEMP\VWDOrVs2015AzurePack.exe

#latest NuGet Manager extension for Visual Studio - https://www.microsoft.com/net/core#windows
Invoke-WebRequest -Uri https://dist.nuget.org/visualstudio-2015-vsix/v3.5.0-beta/NuGet.Tools.vsix -OutFile $env:TEMP\NuGet.Tools.vsix
& $env:TEMP\NuGet.Tools.vsix

#.NET CORE RC2 - https://www.microsoft.com/net/core#windows
Invoke-WebRequest -Uri https://go.microsoft.com/fwlink/?LinkId=798481 -OutFile $env:TEMP\DotNetCore.1.0.0.RC2-VS2015Tools.Preview1.exe
& $env:TEMP\DotNetCore.1.0.0.RC2-VS2015Tools.Preview1.exe /passive
