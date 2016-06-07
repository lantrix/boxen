Set-ExecutionPolicy -Force RemoteSigned
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
iwr https://chocolatey.org/install.ps1 | iex #Choco Install

#Sublime packages
$pControlDir="$($env:HOME)\AppData\Roaming\Sublime Text 3\Installed Packages"
$pControlFile="Package Control.sublime-package"
$pControl="https://packagecontrol.io/Package%20Control.sublime-package"
Invoke-WebRequest -Uri $pControl -OutFile (Join-Path -Path $pControlDir -ChildPath $pControlFile)
$SUBLIME_SYNC_DIR="$env:HOME\Dropbox\syncdata\Sublime\User"
$SUBLIME_USER_DIR="$env:appdata\Sublime Text 3\Packages\User"
Remove-Item -Path $SUBLIME_USER_DIR -Recurse -Force
New-Item -ItemType SymbolicLink -Path $SUBLIME_USER_DIR -Value $SUBLIME_SYNC_DIR
