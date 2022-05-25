#!/usr/bin/env bash

set -e

#Config
GITHUB_USER="lantrix"
RUBY_VERSION="3.1.2"

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
	'/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"' \
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
' git'\
' gnupg2'\
' jq'\
' pyenv'\
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

execute_after_confirm \
	'Install Brew Versions' \
	'brew update && brew cleanup' \
	'brew tap homebrew/cask-versions' \
	'brew tap buo/cask-upgrade' \
	'brew tap homebrew/cask-fonts'

ALL_THE_THINGS_CASK=\
'1password'\
' appzapper'\
' beyond-compare'\
' brave-browser'\
' docker'\
' dropbox'\
' firefox'\
' homebrew/cask/flux'\
' functionflip'\
' gitkraken'\
' google-chrome'\
' insomnia'\
' istat-menus'\
' iterm2'\
' microsoft-remote-desktop'\
' plexamp'\
' powershell'\
' progressive-downloader'\
' sublime-text'\
' visual-studio-code'

execute_after_confirm \
	'Install useful cask packages' \
	"brew install --cask $ALL_THE_THINGS_CASK"

execute_after_confirm \
	"Install RVM" \
	"command curl -sSL https://rvm.io/mpapis.asc | gpg --import -" \
	"command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -" \
	"\\curl -sSL https://get.rvm.io | bash -s stable --ruby" \
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
	"brew install go@1.17"

execute_after_confirm \
	"Install Fast Node Manager" \
	"curl -fsSL https://fnm.vercel.app/install | bash"

#execute_after_confirm \
#	'Install Powerline' \
#	"pip install --user powerline-status" \
#	"pip install --user pyuv"
