#!/usr/bin/env bash

#Config
GITHUB_USER="lantrix"
ADMIN_USER="myadminuser"
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
	'Update Ubuntu' \
	'apt-get update' \
	'apt-get upgrade'

execute_after_confirm \
	'Install Admin User' \
	'groupadd admin' \
	"useradd -d /home/${ADMIN_USER} -m ${ADMIN_USER} -g admin" \
	"passwd ${ADMIN_USER}"

ALL_THE_THINGS_APT=\
' vim'\
' tree'

execute_after_confirm \
	'Get latest Git' \
	'apt-get install python-software-properties software-properties-common' \
	'sudo add-apt-repository ppa:git-core/ppa -y' \
	'sudo apt-get update' \
	'sudo apt-get install git' \
	'git --version'

execute_after_confirm \
	'Install useful packages' \
	"apt-get install $ALL_THE_THINGS_APT" \
