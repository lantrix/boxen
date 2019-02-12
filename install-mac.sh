#!/usr/bin/env bash

#Config
GITHUB_USER="lantrix"
SUBLIME_SYNC_DIR="$HOME/Dropbox/syncdata/Sublime/User"
SUBLIME_USER_DIR="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
ISTAT_PREF_FILE="$HOME/Library/Preferences/com.bjango.istatmenus6.extras.plist"
ISTAT_CONFIG_URI="https://www.dropbox.com/s/sanitized/com.bjango.istatmenus6.extras.plist?dl=1"
ITERM2_PREF_FILE="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
ITERM2_CONFIG_URI="https://www.dropbox.com/s/393p4o2bwbrvf9g/com.googlecode.iterm2.plist?dl=1"
VMWARE_PREF_FILE="$HOME/Library/Preferences/VMware Fusion/preferences"
VMWARE_CONFIG_URI="https://www.dropbox.com/s/kp055mivqdfxlxz/preferences?dl=1"
VAGRANT_LICENCE_URI="https://www.dropbox.com/s/sanitized/license.lic?dl=1"
RUBY_VERSION="2.6.1"

function execute_after_confirm {
	read -p "$1 ($2) ? [y/n] " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		shift
		for var in "$@"
		do
			echo $var
			eval $var
			return_code=$?
			if [[ $return_code != 0 ]] ; then
				exit $return_code
			fi
		done
	fi
}

execute_after_confirm \
	'Generate SSH keys' \
	"ssh-keygen -t rsa -C \"`uname -n`\"" \
	'pbcopy < ~/.ssh/id_rsa.pub  ##### Copied key to clipboard #####'

execute_after_confirm \
	'Install Homebrew' \
	'/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"' \
	'brew doctor'

ALL_THE_THINGS_BREW=\
'autoconf'\
' automake'\
' awscli'\
' bash'\
' bashdb'\
' cli53'\
' cmake'\
' cscope'\
' curl'\
' git'\
' gnupg2'\
' jq'\
' go'\
' mysql'\
' packer'\
' percona-toolkit'\
' syncthing'\
' tig'\
' tree'\
' watch'\
' wget'

execute_after_confirm \
	'Install useful brew packages' \
	"brew install $ALL_THE_THINGS_BREW" \
	"brew tap microsoft/msodbcsql https://github.com/Microsoft/homebrew-mssql-release" \
	"brew update" \
	"ACCEPT_EULA=y brew install msodbcsql"

#Fix node perms if needed
brew install node@8 --without-npm
if [[ `ls -l /usr/local/share/systemtap | awk '{print $3}'` -ne $USER ]]
then
	sudo chown -R $USER /usr/local
fi
brew link --force --overwrite node@8

execute_after_confirm \
	'Install Brew Cask & Versions' \
	'brew tap caskroom/cask' \
	'brew update && brew cleanup' \
	'brew tap homebrew/cask-versions' \
	'brew tap buo/cask-upgrade' \
	'brew tap homebrew/cask-fonts'

ALL_THE_THINGS_CASK=\
'1password'\
' appzapper'\
' beyond-compare'\
' charles'\
' chefdk'\
' disablemonitor'\
' dropbox'\
' firefox'\
' flux'\
' font-source-code-pro'\
' font-source-code-pro-for-powerline'\
' functionflip'\
' gitkraken'\
' google-chrome'\
' istat-menus'\
' iterm2'\
' mysqlworkbench'\
' plexamp'\
' postman'\
' powershell'\
' progressive-downloader'\
' remote-desktop-manager'\
' slack'\
' spotify'\
' sublime-text'\
' tunnelblick'\
' vagrant'\
' virtualbox'\
' visual-studio-code'\
' whatsapp'

execute_after_confirm \
	'Install useful cask packages' \
	"brew cask install $ALL_THE_THINGS_CASK"

execute_after_confirm \
	"Install RVM" \
	"command curl -sSL https://rvm.io/mpapis.asc | gpg --import -" \
	"command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -" \
	"\\curl -sSL https://get.rvm.io | bash -s stable" \
	"source $HOME/.rvm/scripts/rvm" \
	"rvm install $RUBY_VERSION" \
	"rvm --default use $RUBY_VERSION"

execute_after_confirm \
	"Install Homesick" \
	'source $HOME/.rvm/scripts/rvm' \
	'gem install homesick' \
	'homesick clone lantrix/dotfiles-vim' \
	'homesick symlink dotfiles-vim' \
	'homesick clone lantrix/powerline-config' \
	'homesick symlink powerline-config' \
	'vim +PluginInstall +qall' \
	'homesick clone lantrix/dotfiles' \
	'homesick symlink dotfiles'

execute_after_confirm \
	"Install GO" \
	"mkdir $HOME/Go" \
	"mkdir -p $HOME/Go/src/github.com/$GITHUB_USER" \
	"export GOPATH=$HOME/Go" \
	"export GOROOT=/usr/local/opt/go/libexec" \
	"export PATH=$PATH:$GOPATH/bin" \
	"export PATH=$PATH:$GOROOT/bin" \
	"brew install go"

#Sublime Sync Setting
if [[ -d /usr/local/Caskroom/sublime-text ]]
then
	if [[ ! -L $SUBLIME_USER_DIR ]]; then
		echo "Installing Package Control"
		curl --progress-bar -L -o $HOME/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/Package\ Control.sublime-package https://packagecontrol.io/Package%20Control.sublime-package

		echo "Setup Sublime Text 3 Userdata Sync"
		open -a "Sublime Text"
		sleep 2
		kill -9 `ps -ef |grep Sublime |egrep -v 'grep|plugin' | awk '{print $2}'`
		read -p "Press [Enter] key after dropbox configured to sync Sublime user data to $SUBLIME_SYNC_DIR"
		if [[ -d $SUBLIME_SYNC_DIR && -d $SUBLIME_USER_DIR ]]
		then
			rm -r "$SUBLIME_USER_DIR" && ln -s $SUBLIME_SYNC_DIR "$SUBLIME_USER_DIR"
		else
			echo Skipping Sublime Sync Setup - required dirs missing
		fi
	else
		echo Skipping Sublime Sync Setup - already in place
	fi
fi

#iStat Config
if [[ -d /usr/local/Caskroom/istat-menus ]]
then
	echo "Setup iStat Menus config"
	if [[ ! -f $ISTAT_PREF_FILE ]]
	then
		curl --progress-bar -L -o ${ISTAT_PREF_FILE} ${ISTAT_CONFIG_URI}
	else
		echo Existing iStat prefs left alone at $ISTAT_PREF_FILE
	fi
fi

#iTerm2 Config
if [[ -d /usr/local/Caskroom/iterm2 ]]
then
	echo "Setup iTerm2 config"
	if [[ ! -f $ITERM2_PREF_FILE ]]
	then
		curl --progress-bar -L -o ${ITERM2_PREF_FILE} ${ITERM2_CONFIG_URI}
		curl -L https://raw.githubusercontent.com/chriskempson/base16-iterm2/master/base16-ocean.dark.itermcolors > /tmp/base16-ocean.dark.itermcolors
		open /tmp/base16-ocean.dark.itermcolors
	else
		echo Existing iStat prefs left alone at $ITERM2_PREF_FILE
	fi
fi

#Vagrant Config/Licence
if [[ -d /usr/local/Caskroom/vagrant ]]
then
	echo "Install Vagrant VMWare plugin"
	curl --progress-bar -L -o /tmp/license.lic ${VAGRANT_LICENCE_URI}
	vagrant plugin install vagrant-vmware-fusion
	if [[ -f /tmp/license.lic ]]
	then
		vagrant plugin license vagrant-vmware-fusion /tmp/license.lic
	fi
fi

execute_after_confirm \
        "Update npm" \
        "npm install -g npm" \
        "rm /usr/local/opt/node@8/bin/npm" \
        "rm /usr/local/opt/node@8/bin/npx" \
        "ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js npx" \
        "ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js npm"

execute_after_confirm \
        "Install Global packages" \
        "npm install -g azure-cli eslint esvalidate jshint loadtest npm-check recursive-blame serverless"

execute_after_confirm \
	'Install Powerline' \
	"pip install --user powerline-status" \
	"pip install --user pyuv"

