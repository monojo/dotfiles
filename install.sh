#!/usr/bin/env bash

RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
BOLD="$(tput bold)"
NORMAL="$(tput sgr0)"
PLATFORM="unknown"
DIST="unknown"
USER="unknown"

#TODO add MacOS support
install_dep () {
    install_cmd="sudo apt-get install $1"
    echo "${YELLOW}We are going to install $1 on your computer ...${NORMAL}"
    execute "$install_cmd"
}

check_ubuntu_installed () {
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
declare -a UBUNTU_DEPS=("git" "exuberant-ctags" "nodejs" "npm" \
    "tmux" "cmake" "build-essential" "libncurses5-dev" "libgnome2-dev" "libgnomeui-dev" \
    "libgtk2.0-dev" "libatk1.0-dev" "libbonoboui2-dev" \
    "libcairo2-dev" "libx11-dev" "libxpm-dev" "libxt-dev" "python-dev" \
    "python3-dev" "ruby-dev" "liblua5.1-0" "liblua5.1-0-dev" "libperl-dev"\
    "rake" "zsh" \
    "pkg-config" "automake" "libpcre3-dev" "zlib1g-dev" "liblzma-dev" "fcitx" \
    "volumeicon-alsa" "python3-pip" "rofi" "i3" "i3-wm" "i3status"\
    "fcitx-rime" "xclip" "scrot" "vim" "dconf-cli")

declare -a ARCH_DEPS=("grub" "neovim" "git" "ctags" "nodejs" "npm" "yarn"\
    "tmux" "cmake"\
    # gui, display manager, window manager
    "xorg-server" "lightdm" "lightdm-gtk-greeter" "i3"\
    "python3" "rake" "zsh" \
    "fcitx" \
    "volumeicon" "rofi"\
    "xclip" "scrot"\
    # network manager and applet
    "networkmanager" "network-manager-applet" "wpa_supplicant" "wireless_tools"\
    "base-devel" "vim" "htop" "xfce4-terminal" "man" "vi" "pulseaudio" "pamix")

#declare -a MANJARO_DEPS=("grub" "neovim" "git" "ctags" "nodejs" "npm" "yarn"\
    #"tmux" "cmake"\
    ## gui, display manager, window manager
    #"xorg-server" "lightdm" "lightdm-gtk-greeter" "i3"\
    #"python3" "rake" "zsh" \
    #"fcitx" "fcitx-rime"\
    #"volumeicon" "rofi"\
    #"xclip" "scrot"\
    ## network manager and applet
    #"networkmanager" "network-manager-applet" "wpa_supplicant" "wireless_tools"\
        #"base-devel" "vim" "htop" "xfce4-terminal" "man" "vi" "pulseaudio")
    
declare -a MANJARO_DEPS=( "neovim" "git" "ctags" "nodejs" "npm" "yarn"\
    "tmux" "cmake"\
    # gui, display manager, window manager
    "xorg-server" "lightdm" "lightdm-gtk-greeter" "i3"\
    "python3" "rake" "zsh" \
    # Input method
    "fcitx" "fcitx-rime"\
    "volumeicon" "rofi"\
    "xclip" "scrot"\
    # network manager and applet
    "networkmanager" "network-manager-applet" "wpa_supplicant" "wireless_tools"\
    "base-devel" "vim" "htop" "xfce4-terminal" "man" "vi" "pulseaudio" \
    "polkit-kde-agent" "nautilus" "openssh" "gvfs-smb" "feh" "udiskie" "dunst" )

declare -a MANJARO_AURS=( "zotero" "okular" "chromium" "rtags" "ly" "anki" )

execute () {
    echo "$1"
    eval "$1"
}

install_ubuntu_deps () {
    for dep in ${UBUNTU_DEPS[@]}
    do
        check_ubuntu_installed $dep
    done
}

install_arch_dep () {
    install_cmd="pacman -S $1"
    echo "${YELLOW}We are going to install $1 on your computer ...${NORMAL}"
    execute "$install_cmd"
    echo "Y\n"
}


install_manjaro_dep () {
    install_cmd="sudo pacman -S $1"
    echo "${YELLOW}We are going to install $1 on your computer ...${NORMAL}"
    execute "$install_cmd"
    echo "Y\n"
}

install_manjaro_dep () {
    install_cmd="sudo yay -S $1"
    echo "${YELLOW}We are going to install $1 on your computer ...${NORMAL}"
    execute "$install_cmd"
    echo "Y\n"
}

install_arch_deps () {
    for dep in ${ARCH_DEPS[@]}
    do
        install_arch_dep $dep
    done
}

install_manjaro_deps () {
    for dep in ${MANJARO_DEPS[@]}
    do
        install_manjaro_dep $dep
    done
}

install_manjaro_aurs () {
    for dep in ${MANJARO_AURS[@]}
    do
        install_manjaro_aur $dep
    done
}

#setup_network_service () {
    #systemctl enable NetworkManager.service
#}

#setup_arch_service () {
    #setup_network_service()
    ##setup_service()
    ##setup_network_service()
#}

check_platform () {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        #Linux OS 
        PLATFORM="Linux"
        DIST=$(tr -s ' \011' '\012' < /etc/issue | head -n 1)
        echo $DIST
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        PLATFORM="OSX"
    fi
}

## if support efi, then use efi with gpt
## else use bios with mbr
#EFIVARS_DIR="/sys/firmware/efi/efivars"
#auto_partition () {
    #if [ -d "$EFIVARS_DIR" ]; then
        #boot_mode="efi";
    #else
        #boot_mode="bios";
    #fi
    #echo "Boot mode $boot_mode"
#}

#setup_arch () {
    #auto_partition()

#}

check_platform

if [ "$PLATFORM" == "Linux" ]; then
    if [ "$DIST" == "Ubuntu" ]; then
        install_ubuntu_deps
    elif [ "$DIST" == "Arch" ]; then
        #setup_arch
        install_arch_deps
        # setup arch services
        #setup_arch_service
    elif [ "$DIST" == "Manjaro" ]; then
        install_manjaro_deps
        install_manjaro_aurs
    fi
fi

#git clone the dotfiles and start installation
if [ ! -d "$HOME/.yadr" ]; then
    echo "Installing YADR for the first time"
    git clone --depth=1 https://github.com/monojo/dotfiles.git "$HOME/.yadr"
    cd "$HOME/.yadr"
    [ "$1" = "ask" ] && export ASK="true"
    #rake install
    python3 install.py
else
    echo "YADR is already installed"
fi
