# Lantrix - Boxen

Scripts for setting up new [boxen](http://www.urbandictionary.com/define.php?term=boxen)

## Mac OS X

### Pre-requisites

Homebrew requires the full and latest Xcode; or Xcode command line tools.
You can get the command line tools installed by running in terminal:

    xcode-select --install

### Usage

_Tested and working on Yosemite_

Download and `bash install-mac.sh` or if you want to live on the edge:

    bash <(curl -fsSL https://raw.githubusercontent.com/lantrix/boxen/master/install-mac.sh)

## Linux

### Pre-requisites

_TBD_

### Usage

_TBD_

## Windows 10

### Pre-requisites

Windows 10 OS fresh installation.

### Usage

On a clean Windows 10 install, from an elevated/privileged cmd.exe launch the [boxstarter](http://boxstarter.org):

	.\install-windows.cmd

 * This will also run some post-boxstarter script `Complete-Bootstrap.ps1` including:
 	- Install choco
	- Install [.NET CORE 1.0.1 tools Preview 2](https://www.microsoft.com/net/core#windowsvs2015)
 	- Install [Azure VS2015 SDK](https://msdn.microsoft.com/library/mt695655.aspx)
