from pathlib import Path
import shutil
import subprocess
import os
import json


HOME = Path.home()
CWD = Path.cwd()
BIN = HOME / "bin/"


def install_files(files, method="symlink", dest="home"):
    """Install dot files to a destination, by default install at $HOME dir
        dest: home, config, jbin and other places with full absolute path
    """
    global HOME, CWD
    for f in files:
        dot_file = f".{f.name}"
        config_folder = f".{str(f)}"
        source = CWD / f
        if dest == "home":
            target = HOME / dot_file
        elif dest == "config":
            target = HOME / config_folder
        elif dest == "bin":
            target = HOME / f"bin/{f.name}"
        else:
            target = Path(dest)

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
    install_command = """
                        vim --noplugin -u $HOME/.vim/vimplug.vim -N
                         \"+set hidden\" \"+syntax on\"
                         +PlugInstall +qall
                      """
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

    os.system("git submodule update --init --recursive")


def install_imgur_screenshot():
    os.system("sudo update-desktop-database")


def install_fonts():
    os.system("fc-cache -vf ~/.fonts")


def setup_submodules():
    "init submodule and download each of them"
    print("======================================================")
    print("Downloading dotfile submodules...please wait")
    print("======================================================")

    os.system("git submodule update --init --recursive")
    os.system("git submodule update --recursive")
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
            install_files(CWD.glob(key), *config)


def post_install():
    post_jobs = {
            install_imgur_screenshot, install_fonts, install_prezto,
            install_vim_plug, success_msg
            }
    for job in post_jobs:
        job()


if __name__ == "__main__":
    """Dot files is the set contains dot file pattern as the key,
        and config list as value
    """
    pre_install()
    install()
    post_install()
