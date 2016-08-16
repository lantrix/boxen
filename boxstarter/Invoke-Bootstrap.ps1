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
  cinst githubforwindows
  cinst rdm
  cinst putty
  cinst sourcecodepro

  # Media
  cinst spotify

  # Powershell
  cinst windowsazurepowershell
  cinst AWSTools.Powershell
  cinst poshgit

  # Dev
  cinst visualstudio2015community -packageParameters "--AdminFile https://raw.githubusercontent.com/lantrix/boxen/master/boxstarter/AdminDeployment.xml"
  cinst visualstudiocode
  cinst sysinternals
  cinst windbg
  cinst dotPeek

  # Java Dev
  cinst jdk7
  cinst intellijidea-community
  cinst gradle

  # NodeJS
  cinst nodejs

  # VMs
  cinst vagrant
  cinst virtualbox

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
