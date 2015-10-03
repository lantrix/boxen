#!/usr/bin/env bash

#Config
GITHUB_USER="lantrix"
RUBY_VERSION="2.2"

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
	"Setup RVM" \
	"curl -sSL https://rvm.io/mpapis.asc | gpg --import -" \
	"\\curl -L https://get.rvm.io | bash -s stable --ruby --autolibs=enable --auto-dotfiles" \
	"source $HOME/.rvm/scripts/rvm" \
	"rvm install $RUBY_VERSION" \
	"rvm --default use $RUBY_VERSION"

execute_after_confirm \
	"Install Homesick" \
	'gem install homesick' \
	"homesick clone ${GITHUB_USER}/dotfiles" \
	"homesick symlink dotfiles" \
	"homesick clone ${GITHUB_USER}/dotfiles-vim" \
	"homesick symlink dotfiles-vim" \
	'vim +PluginInstall +qall'

execute_after_confirm \
	"Install Syncthing" \
	"curl -s https://syncthing.net/release-key.txt | sudo apt-key add -" \
	"echo deb http://apt.syncthing.net/ syncthing release | sudo tee /etc/apt/sources.list.d/syncthing-release.list" \
	"sudo apt-get update" \
	"sudo apt-get install syncthing"

execute_after_confirm \
	"Install Powerline" \
	"pip install --user git+git://github.com/powerline/powerline"
