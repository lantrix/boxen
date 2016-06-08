#Sublime packages in Dropbox
Write-Host "Press any key once Dropbox Synced ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

$SUBLIME_SYNC_DIR="$env:HOME\Dropbox\syncdata\Sublime\User"
$SUBLIME_USER_DIR="$env:appdata\Sublime Text 3\Packages\User"

if ((test-path $SUBLIME_SYNC_DIR) -eq $true) {
    Write-Host "Setup Sublime config from Dropbox"
    $pControlDir="$($env:HOME)\AppData\Roaming\Sublime Text 3\Installed Packages"
    $pControlFile="Package Control.sublime-package"
    $pControl="https://packagecontrol.io/Package%20Control.sublime-package"
    Invoke-WebRequest -Uri $pControl -OutFile (Join-Path -Path $pControlDir -ChildPath $pControlFile)

    Remove-Item -Path $SUBLIME_USER_DIR -Recurse -Force
    New-Item -ItemType SymbolicLink -Path $SUBLIME_USER_DIR -Value $SUBLIME_SYNC_DIR
} else {
    Write-Error "Synced dir not available: $SUBLIME_SYNC_DIR"
}
