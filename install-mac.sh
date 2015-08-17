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
	'brew doctor'
	'brew install caskroom/cask/brew-cask'

ALL_THE_THINGS=\
'git'\
' git-flow'\
' jq'\
' gpg'\
' wget'

execute_after_confirm \
	'Install useful packages' \
	"brew install $ALL_THE_THINGS"

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
