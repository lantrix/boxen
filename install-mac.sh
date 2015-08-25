#!/usr/bin/env bash

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
	'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"' \
	'brew doctor' \
	'brew install caskroom/cask/brew-cask'

execute_after_confirm \
	'Install Fonts' \
	'curl -L -o /tmp/envy.zip https://www.dropbox.com/s/21ooc7mmr3d7h4c/envy.zip?dl=1' \
	'unzip /tmp/envy.zip -d /tmp/' \
	'mv /tmp/*ttf ~/Library/Fonts/'

ALL_THE_THINGS_BREW=\
'git'\
' git-flow'\
' jq'\
' gpg'\
' wget'\
' node'

execute_after_confirm \
	'Install useful brew packages' \
	"brew install $ALL_THE_THINGS_BREW"

ALL_THE_THINGS_CASK=\
'sublime-text'\
' appzapper'\
' 1password'\
' google-chrome'\
' slack'

execute_after_confirm \
	'Install useful cask packages' \
	"brew cask install $ALL_THE_THINGS_CASK"

RUBY_VERSION="2.2.1"
execute_after_confirm \
	"Install RVM" \
	"\\curl -sSL https://get.rvm.io | bash -s stable" \

execute_after_confirm \
	"Install Homesick" \
	'gem install homesick' \
	'homesick clone lantrix/dotfiles-vim' \
	'homesick symlink dotfiles-vim' \
	'homesick clone lantrix/dotfiles' \
	'homesick symlink dotfiles'

GITHUB_USER="lantrix"
execute_after_confirm \
	"Install GO" \
	"mkdir $HOME/Go" \
	"mkdir -p $HOME/Go/src/github.com/$GITHUB_USER" \
	"export GOPATH=$HOME/Go" \
	"export GOROOT=/usr/local/opt/go/libexec" \
	"export PATH=$PATH:$GOPATH/bin" \
	"export PATH=$PATH:$GOROOT/bin" \
	"brew install go"
