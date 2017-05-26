#!/bin/bash
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
BOLD="$(tput bold)"
NORMAL="$(tput sgr0)"

execute () {
	echo "$1"
	eval "$1"
}

install_dep () {
	install_cmd="sudo apt-get install $1"
	echo "${YELLOW}We are going to install $1 on your computer ...${NORMAL}"
	execute "$install_cmd"
}

check_installed () {
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $1| \
        grep "install ok installed")
    if [ "" == "$PKG_OK" ]; then
        echo "${RED}$1 hasn't been installed!${NORMAL}"
        sudo apt-get --force-yes --yes install $1
        install_dep $1
    else
		echo "${GREEN}$1 is installed!${NORMAL}"
	fi
}

declare -a DEPS=("vim" "git" "exuberant-ctags" "silversearcher-ag" "nodejs" "npm" "tmux")
for dep in ${DEPS[@]}
do
    check_installed $dep
done

if [ ! -d "$HOME/.yadr" ]; then
    echo "Installing YADR for the first time"
    git clone --depth=1 https://github.com/monojo/dotfiles.git "$HOME/.yadr"
    cd "$HOME/.yadr"
    [ "$1" = "ask" ] && export ASK="true"
    rake install
else
    echo "YADR is already installed"
fi
