try {
  # Tools
  cinst slack
  cinst dropbox
  cinst 1password
  cinst sublimetext3
  cinst googlechrome
  cinst beyondcompare
  cinst sourcetree
  cinst git -params "/GitAndUnixToolsOnPath /NoAutoCrlf"
  cinst git-credential-manager-for-windows
  cinst poshgit
  cinst rdm
  cinst putty
  cinst sourcecodepro

  # Dev
  cinst visualstudio2015community -packageParameters "--AdminFile https://raw.githubusercontent.com/lantrix/boxen/master/boxstarter/AdminDeployment.xml"
  cinst githubforwindows
  cinst sysinternals
  cinst windbg
  cinst dotPeek
  cinst windowsazurepowershell

  # Basic windows stuff
  Install-WindowsUpdate -AcceptEula
  Update-ExecutionPolicy Unrestricted
  Set-ExplorerOptions -showHidenFilesFoldersDrives -showProtectedOSFiles -showFileExtensions
  Set-TaskbarSmall

  Write-ChocolateySuccess 'Windows boostrapped'
} catch {
  Write-ChocolateyFailure 'Windows Bootstrap: ' $($_.Exception.Message)
  throw
}
