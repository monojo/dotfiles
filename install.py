from pathlib import Path
import shutil
import subprocess
import os
import json
import sys


HOME = Path.home()
CWD = Path.cwd()
BIN = HOME / "bin/"


# TODO: to non-glob version?
def install_file(files, method="symlink", dest="home"):
    """Install dot files to a destination, by default install at $HOME dir
        files:  the list returned by glob provided pattern
        dest: home, config, jbin and other places with full absolute path
    """
    global HOME, CWD

    for f in files:
        dot_file = f".{f.name}"
        config_folder = f".{str(f)}"
        source = CWD / f"{f.name}"
        if dest == "home":
            target = HOME / dot_file
        elif dest == "config":
            target = HOME / config_folder
        elif dest == "bin":
            target = HOME / f"bin/{f}"
        else:
            target = Path(dest).expanduser()

        print(f"=========={f}==========")
        print(f"Source: {source}")
        print(f"Target: {target}")

        if target.exists() and (not target.is_symlink()):
            print(f"Overwriting {target}")

        if method == "symlink":
            try:
                target.symlink_to(source)
            except FileExistsError:
                print(f"{target} file existed")
            except FileNotFoundError:
                path = target.parent
                if not path.exists():
                    try:
                        path.mkdir(parents=True)
                        target.symlink_to(source)
                    except FileNotFoundError as e:
                        print(e)
                    except FileExistsError as e:
                        print(e)
        else:
            try:
                shutil.copy(source, target)
            except FileExistsError:
                print(f"{target} file existed")
            except FileNotFoundError:
                path = target.parent
                if not path.exists():
                    try:
                        path.mkdir(parents=True)
                        shutil.copy(source, target)
                    except FileNotFoundError as e:
                        print(e)
                    except FileExistsError as e:
                        print(e)


def install_vim_plug():
    print("======================================================")
    print("Installing and updating vim-plug.")
    print("======================================================")

    vim_plug_path = CWD / "vim/autoload/plug.vim"
    if not vim_plug_path.exists():
        subprocess.call([
         "curl", "-fLo", str(vim_plug_path), "--create-dirs",
         "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
          ])
    install_command = f"vim --noplugin -u {HOME}/.vim/vimplug.vim -N \"+set hidden\" \"+syntax on\" +PlugInstall +qall"
    os.system(install_command)


def install_prezto():
    "Appending a line to .zshrc to let it include our extensions"
    print()
    print("Appending our own extension to .zshrc")

    zshrc = HOME / ".zshrc"
    # Append this line to zshrc to load our customize zsh config
    config_code = "for config_file ($HOME/.yadr/zsh/*.zsh) source $config_file"
    with open(zshrc, "a") as f:
        f.write(config_code)

    zsh = subprocess.call(["which", "zsh"])
    if zsh:
        subprocess.call(["chsh", "-s", str(zsh)])
    os.system("git submodule update --init --recursive")


def install_imgur_screenshot():
    os.system("sudo update-desktop-database")


def install_fonts():
    os.system("fc-cache -vf ~/.fonts")


def install_term_theme():
    os.system("./gnome-terminal/install.sh")


def setup_submodules():
    "init submodule and download each of them"
    print("======================================================")
    print("Downloading dotfile submodules...please wait")
    print("======================================================")

    os.system("git submodule update --init --recursive")
    # os.system("git submodule update --recursive")
    os.system("git clean -df")


def success_msg():
    print(" |  __ \\      | | |  ____(_) |     ")
    print(" | |  | | ___ | |_| |__   _| | ___ ")
    print(" | |  | |/ _ \\| __|  __| | | |/ _ \\")
    print(" | |__| | (_) | |_| |    | | |  __/")
    print(" |_____/ \\___/ \\__|_|    |_|_|\\___|")
    print("Dotfile has been installed. Please restart your terminal and vim.")


def pre_install():
    setup_submodules()


def install():
    with open("./dotfiles.json") as file_list:
        dot_files = json.load(file_list)
        # install dot files
        for key, config in dot_files.items():
            install_file(Path(".").glob(key), *config)


def post_install():
    post_jobs = {
            # TODO put post action into json string
            install_imgur_screenshot,
            install_fonts,
            install_vim_plug,
            install_prezto,
            install_term_theme,
            success_msg
            }
    for job in post_jobs:
        job()


def install_package(package):
    with open("./dotfiles.json") as file_list:
        dot_files = json.load(file_list)
        # TODO: better search
        for key, config in dot_files.items():
            #install_files(Path(".").glob(key), *config)
            if key == package:
                install_file(Path(".").glob(key), *config)


def install_test():
    with open("./test.json") as file_list:
        dot_files = json.load(file_list)
        for key, config in dot_files.items():
            #install_files(Path(".").glob(key), *config)
            print(key, config)
            if key == "test" or key == "test/test_rc":
                install_file(Path(".").glob(key), *config)

if __name__ == "__main__":
    """Dot files is the set contains dot file pattern as the key,
        and config list as value
    """
    argc = len(sys.argv)
    if argc == 1 or sys.argv[1] == "all":
        pre_install()
        install()
        post_install()
    elif sys.argv[1] == "test":
        install_test()
    else:
        for pack in sys.argv:
            install_package(pack)
