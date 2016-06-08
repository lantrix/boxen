$profile = "$env:USERPROFILE\Dropbox\syncdata\WindowsPowerShell\Profile.ps1"
if ( (test-path $profile) -ne $true) {New-Item $profile -ItemType File}
. $profile
