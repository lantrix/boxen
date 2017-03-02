try {
  # Tools
  choco upgrade slack
  choco upgrade dropbox
  choco upgrade 1password
  choco upgrade sublimetext3
  choco upgrade googlechrome
  choco upgrade beyondcompare
  choco upgrade sourcetree
  choco upgrade git -params "/GitAndUnixToolsOnPath /NoAutoCrlf"
  choco upgrade git-credential-manager-for-windows
  choco upgrade githubforwindows
  choco upgrade rdm
  choco upgrade putty
  choco upgrade sourcecodepro

  # Media
  choco upgrade spotify

  # Dev
  choco upgrade visualstudio2015community -packageParameters "--AdminFile https://raw.githubusercontent.com/lantrix/boxen/master/boxstarter/AdminDeployment.xml"
  choco upgrade visualstudiocode
  choco upgrade sysinternals
  choco upgrade windbg
  choco upgrade dotPeek

  # Java Dev
  choco upgrade jdk8
  choco upgrade intellijidea-community
  choco upgrade gradle

  # NodeJS
  choco upgrade nodejs-lts

  # VMs
  choco upgrade vagrant
  choco upgrade virtualbox

  Write-ChocolateySuccess 'Windows Packages Upgraded'
} catch {
  Write-ChocolateyFailure 'Windows Bootstrap: ' $($_.Exception.Message)
  throw
}
