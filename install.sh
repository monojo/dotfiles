#!/bin/sh
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
	printf "${YELLOW}We are going to install $1 on your computer ...${NORMAL}\n"
	execute "$install_cmd"
}

check_installed () {
	loc=$(whereis "$1")
	if [ "${#loc}" -gt $((${#1}+1)) ]; then
		printf "${GREEN}$1 is installed!${NORMAL}\n"
	else
		printf "${RED}$1 hasn't been installed!${NORMAL}\n"
		install_dep $1
	fi
}
#check deps first
DEPS=(vim git exuberant-ctags silversearcher-ag nodejs npm)
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
