#PowerShell Profile in Dropbox
Write-Host "Press any key once Dropbox Synced ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

$DocumentsPath = [Environment]::GetFolderPath("MyDocuments")
$syncedProfile = "$env:HOME\Dropbox\syncdata\WindowsPowerShell\Profile.ps1"
$iseProfile = Join-Path $DocumentsPath -ChildPath "WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1"
$psProfile = Join-Path $DocumentsPath -ChildPath "WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

if ((test-path $syncedProfile) -eq $true) {
    Write-Host "Setup PowerShell Profile from Dropbox"
    Remove-Item -Path $iseProfile -Force -ErrorAction SilentlyContinue
    Remove-Item -Path $psProfile -Force -ErrorAction SilentlyContinue
    Copy-Item "..\powershell\Microsoft.PowerShell_profile.ps1" -Destination $psProfile
    Copy-Item "..\powershell\Microsoft.PowerShellISE_profile.ps1" -Destination $iseProfile
} else {
    Write-Error "Synced profile not available: $syncedProfile"
}
