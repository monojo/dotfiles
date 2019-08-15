#!/bin/bash
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
BOLD="$(tput bold)"
NORMAL="$(tput sgr0)"
PLATFORM="unknown"

execute () {
    echo "$1"
    eval "$1"
}

check_platform () {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        #Linux OS 
        PLATFORM="Linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        PLATFORM="OSX"
    fi
}

#TODO add MacOS support
install_dep () {
    install_cmd="sudo apt-get install $1"
    echo "${YELLOW}We are going to install $1 on your computer ...${NORMAL}"
    execute "$install_cmd"
}

check_installed () {
    #TODO this won't work for pkg that user compiled by themself
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

# The Linux dependencies needed
declare -a LINUX_DEPS=("git" "exuberant-ctags" "nodejs" "npm" \
    "tmux" "cmake" "build-essential" "libncurses5-dev" "libgnome2-dev" "libgnomeui-dev" \
    "libgtk2.0-dev" "libatk1.0-dev" "libbonoboui2-dev" \
    "libcairo2-dev" "libx11-dev" "libxpm-dev" "libxt-dev" "python-dev" \
    "python3-dev" "ruby-dev" "lua5.1" "lua5.1-dev" "libperl-dev" "rake" "zsh" \
    "pkg-config" "automake" "libpcre3-dev" "zlib1g-dev" "liblzma-dev" "fcitx" \
    "volumeicon-alsa" \
"fcitx-rime" "xclip" "scrot")

check_platform

if [ "$PLATFORM" == "Linux" ]; then
    for dep in ${LINUX_DEPS[@]}
    do
        check_installed $dep
    done
fi

#git clone the dotfiles and start installation
if [ ! -d "$HOME/.yadr" ]; then
    echo "Installing YADR for the first time"
    git clone --depth=1 https://github.com/monojo/dotfiles.git "$HOME/.yadr"
    cd "$HOME/.yadr"
    [ "$1" = "ask" ] && export ASK="true"
    rake install
else
    echo "YADR is already installed"
fi
