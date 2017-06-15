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

  # Dev
  #cinst visualstudio2015community -packageParameters "--AdminFile https://raw.githubusercontent.com/lantrix/boxen/master/boxstarter/AdminDeployment.xml"
  cinst visualstudiocode
  cinst sysinternals
  cinst windbg
  cinst dotPeek

  # Java Dev
  cinst jdk8
  cinst intellijidea-community
  cinst gradle

  # NodeJS
  cinst nodejs-lts

  # VMs
  cinst vagrant
  cinst virtualbox

  # Basic windows stuff
  Install-WindowsUpdate -AcceptEula
  Update-ExecutionPolicy Unrestricted
  Set-ExplorerOptions -showHidenFilesFoldersDrives -showProtectedOSFiles -showFileExtensions
  Set-TaskbarSmall

} catch {
  throw "Windows Bootstrap: $($_.Exception.Message)"
}
