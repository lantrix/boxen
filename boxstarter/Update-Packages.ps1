try {
  # Tools
  cup slack
  cup dropbox
  cup 1password
  cup sublimetext3
  cup googlechrome
  cup beyondcompare
  cup sourcetree
  cup git -params "/GitAndUnixToolsOnPath /NoAutoCrlf"
  cup git-credential-manager-for-windows
  cup githubforwindows
  cup rdm
  cup putty
  cup sourcecodepro

  # Media
  cup spotify

  # Powershell
  cup windowsazurepowershell
  cup AWSTools.Powershell
  cup poshgit

  # Dev
  cup visualstudio2015community -packageParameters "--AdminFile https://raw.githubusercontent.com/lantrix/boxen/master/boxstarter/AdminDeployment.xml"
  cup visualstudiocode
  cup sysinternals
  cup windbg
  cup dotPeek

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
