#PowerShell Profile in Dropbox
Write-Host "Press any key once Dropbox Synced ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

$syncedProfile = "$env:HOME\Dropbox\syncdata\WindowsPowerShell\Profile.ps1"
$iseProfile = "$env:HOME\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1"
$psProfile = "$env:HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

if ((test-path $syncedProfile) -eq $true) {
    Write-Host "Setup PowerShell Profile from Dropbox"
    Remove-Item -Path $iseProfile -Force
    Remove-Item -Path $psProfile -Force
    Copy-Item "..\powershell\Microsoft.PowerShell_profile.ps1" -Destination $psProfile
    Copy-Item "..\powershell\Microsoft.PowerShellISE_profile.ps1" -Destination $iseProfile
} else {
    Write-Error "Synced profile not available: $syncedProfile"
}
