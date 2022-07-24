#!/usr/bin/bash

RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
BOLD="$(tput bold)"
NORMAL="$(tput sgr0)"
PLATFORM="unknown"
DIST="unknown"
USER="unknown"

# Dependencies for Linux distros
# TODO add MacOS support

# Ubuntu
declare -a ubuntu=("git" "nodejs" "npm" "vim" \
    "tmux" "cmake" "build-essential" "libncurses5-dev" "libgnome2-dev" \
    "libgnomeui-dev" "libgtk2.0-dev" "libatk1.0-dev" "libbonoboui2-dev" \
    "libcairo2-dev" "libx11-dev" "libxpm-dev" "libxt-dev" "python-dev" \
    "python3-dev" "ruby-dev" "liblua5.1-0" "liblua5.1-0-dev" "libperl-dev"\
    "rake" "zsh" \
    "pkg-config" "automake" "libpcre3-dev" "zlib1g-dev" "liblzma-dev" "fcitx" \
    "volumeicon-alsa" "python3-pip" \
    "fcitx-rime" "xclip" "scrot" "dconf-cli"
    #deprecated "exuberant-ctags"
    #"i3" "i3-wm" "i3status" "rofi"
    )


# debian/pi os lite
declare -a debian=("curl" "git" "tmux" "vim" "xserver-xorg" "ripgrep" "zsh"\
    "python3" "python3-pip" "fontconfig" "htop")

# Arch
declare -a arch=("grub" "neovim" "git" "ctags" "nodejs" "npm" "yarn"\
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

# Manjaro
declare -a manjaro=("neovim" "git" "ctags" "nodejs" "npm" "yarn"\
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
    "polkit-kde-agent" "nautilus" "openssh" "gvfs-smb" "feh" "udiskie" "dunst"\
    # Fonts
    "ttf-fantasque-sans-mono" "ttf-dejavu" "ttf-fira-code" \
    "ttf-roboto" "wqy-zenhei" "wqy-microhei" "adobe-source-han-serif-cn-fonts"\
    "adobe-source-han-sans-cn-fonts" "ttf-droid"\
    # MISC
    "foliate" "firefox" "picocom" "gparted" "gdb" "virtualbox" "python-pip"\
    "sudo" "vlc" "man-db" "man-pages" "ncdu" "nfs-utils" "ntp" "okular"\
    "pamac-gtk" "libreoffice-still" "mhwd-db" "dhcpcd" "exfat-utils" "emacs"\
    "dmenu-manjaro" "unzip" "arandr" "autorandr" "python-pynvim" "gzip"\
    "hibernator" "ripgrep" "bluez" "bluz-utils" "blueman" "cgdb" "fzf"\
    "radare2" "fd")

# Manjaro AURS
declare -a manjaro_aur=("ly" "anki" "zoom" "obsidian-appimage" "dropbox" \
    "xkill-shortcut" "pamix-git"
    #deprecated
    #"zotero" "chromium" "rtags" "mattermost-desktop" "pulse-secure"
    )

# Sytemd services to be enabled
# Display Manager, permission, time sync, ssh
declare -a systemd_services=("ly.service" "polkit" "systemd-timesyncd.service"\
    "sshd.service" "ccls-git")

# nodejs apps
declare -a npm_apps=("nativefier" "tldr")

execute () {
    echo "${GREEN}$1${NORMAL}"
    eval "$1"
}

info () {
    echo "${YELLOW}$1${NORMAL}"
}

warn () {
    echo "${RED}$1${NORMAL}"
}

fin () {
    echo "${GREEN}$1${NORMAL}"
}

install_debian_dep () {
    #TODO this won't work for pkg that user compiled by themself
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $1| \
        grep "install ok installed")
    if [ "" == "$PKG_OK" ]; then
        warn "$1 hasn't been installed!"
        info "We are going to install $1 on your computer ..."
        cmd="sudo apt --yes install $1"
        execute "$cmd"
    else
        echo "${GREEN}$1 is installed!${NORMAL}"
    fi
}

update_debian_deps () {
    cmd="sudo apt update"
    execute "$cmd"
}

install_ubuntu_dep () {
    #TODO this won't work for pkg that user compiled by themself
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $1| \
        grep "install ok installed")
    if [ "" == "$PKG_OK" ]; then
        warn "$1 hasn't been installed!"
        info "We are going to install $1 on your computer ..."
        cmd="sudo apt --yes install $1"
        execute "$cmd"
    else
        fin "$1 is installed!"
    fi
}

install_arch_dep () {
    install_cmd="pacman -S --noconfirm $1"
    info "We are going to install $1 on your computer ..."
    execute "$install_cmd"
}


install_manjaro_dep () {
    install_cmd="sudo pacman -S --noconfirm $1"
    info "We are going to install $1 on your computer ..."
    execute "$install_cmd"
}

install_manjaro_aur () {
    install_cmd="yay -S $1"
    info "We are going to install $1 on your computer ..."
    execute "$install_cmd"
    echo "Y\n"
}

install_deps () {
    deps_name=$1[@]
    update_$1_deps
    deps=("${!deps_name}")
    for dep in ${deps[@]}
    do
       install_$1_dep $dep \
       echo $dep
    done
}


enable_systemd_service () {
    cmd="sudo systemctl enable $1"
    info "We are going to install $1 on your computer ..."
    execute "$cmd"
}

enable_systemd_services () {
    for service in ${systemd_services[@]}; do
        enable_systemd_service $service
    done
}

install_npm_app () {
    cmd="sudo npm install -g $1"
    info "We are going to install $1 on your computer ..."
    execute "$cmd"
}

install_npm_apps () {
  for app in ${npm_apps[@]}; do
      install_npm_app $app
  done
}

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

link () {
    cmd="ln -snf $1 $2"
    execute "$cmd"
}

link_home () {
    files="$HOME/.dotfiles/home/*"
    for f in $files; do
        fname=$(basename $f)
        target="$HOME/.$fname"
        if [ -d "$target" ] || [ -f "$target" ]; then
            echo "${RED}$f existed${NORMAL}"
            continue
        else
            link "$f" "$HOME/.$fname"
        fi
    done
}

install_prezto () {
    dest="$HOME/.zprezto"
    if [ ! -d $dest ]; then
        cmd="git clone --recursive https://github.com/sorin-ionescu/prezto.git $dest"
        execute "$cmd"
    fi

    rcfiles="$HOME/.zprezto/runcoms/*"
    # link prezto zshrc
    for rcfile in $rcfiles; do
        echo $rcfile
        fname=$(basename $rcfile)
        if [ "$fname" != "README.md" ] && [ ! -f "$HOME/.$fname" ]; then
            link "$rcfile" "$HOME/.$fname"
        fi
    done
    cur_shell=$(basename $SHELL)
    if [ "$cur_shell" != "zsh" ]; then
        cmd="chsh -s /bin/zsh"
        execute "$cmd"
    fi
    #echo "for config_file ($HOME/.dotfiles/zsh/*.zsh) source \$config_file" > "$HOME/.zshrc"
    #update prezto
    #cd .zprezto
    #git pull
    #git submodule sync --recursive
    #git submodule update --init --recursive
}

install_vimplug () {
    dest="$HOME/.vim/autoload/plug.vim"
    # Install vimplug
    if [ ! -d $dest ]; then
        cmd="curl -fLo $dest --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        execute "$cmd"
        # Install plugins
        cmd="vim --noplugin -u ~/.vim/vimplug.vim -N +PlugInstall +qall"
        execute "$cmd"
    fi
}

install_fonts () {
    cmd="fc-cache -vf ~/.fonts"
    execute "$cmd"
}

install_tpm () {
    dest="$HOME/.tmux/plugins/tpm"
    if [ ! -d $dest ]; then
        cmd="git clone https://github.com/tmux-plugins/tpm.git $dest"
        execute "$cmd"
        cmd="$dest/bin/install_plugins"
        execute "$cmd"
        cmd="tmux source $HOME/.tmux/plugins/tpm"
        execute "$cmd"
    fi
}

install_doom () {
    if [ -x "$(command -v emacs)" ]; then
        dest="$HOME/.emacs.d"
        if [ ! -d $dest ]; then
            cmd="git clone --depth 1 https://github.com/doomemacs/doomemacs $dest"
            execute "$cmd"
            cmd="$HOME/.emacs.d/bin/doom install"
            execute "$cmd"
        fi
    fi
}

install_docker () {
    if [ ! -x "$(command -v docker)" ]; then
        cmd="curl -fsSL https://get.docker.com -o $HOME/get-docker.sh"
        execute "$cmd"
        cmd="sudo sh $HOME/get-docker.sh"
        execute "$cmd"
        cmd="rm $HOME/get-docker.sh"
        execute "$cmd"
    fi
}

do_post_jobs () {
    install_prezto
    install_fonts
    install_vimplug
    install_tpm
    install_doom
    install_docker
}

check_platform

if [ "$PLATFORM" == "Linux" ]; then
    if [ "$DIST" == "Ubuntu" ]; then
        install_deps ubuntu
    elif [ "$DIST" == "Arch" ]; then
        install_deps arch
    elif [ "$DIST" == "Manjaro" ]; then
        install_deps manjaro
        install_deps manjaro_aur
        enable_systemd_services
    elif [ "$DIST" == "Debian" ]; then
        install_deps debian
    fi
elif [ "$PLATFORM" == "OSX" ]; then
    echo "TODO: OSX"
fi


if [ ! -d "$HOME/.dotfiles" ]; then
    info "Cloning dotfiles"
    cmd="git clone --depth=1 https://github.com/monojo/dotfiles.git $HOME/.dotfiles"
    execute "$cmd"
else
    info "dotfiles is already cloned"
fi

link_home
do_post_jobs

fin "Success"
