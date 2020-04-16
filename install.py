from pathlib import Path
import shutil
import subprocess
import os


def install_files(files, method="symlink", dest="home"):
    home = Path.home()
    cwd = Path.cwd()
    for f in files:
        dot_file = f".{f.name}"
        dot_folder = f".{str(f)}"
        source = cwd / f
        if dest == "home":
            target = home / dot_file
        elif dest == "config":
            target = home / dot_folder
            path = target.parent
            if not path.exists():
                try:
                    path.mkdir(parents=True)
                except FileNotFoundError as e:
                    print(e)
                except FileExistsError as e:
                    print(e)

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
        else:
            shutil.copy(source, target)


def install_vim_plug():
    print("======================================================")
    print("Installing and updating vim-plug.")
    print("""
         The installer will now proceed to run PlugInstall to install vim-plug
         """)
    print("======================================================")

    vim_plug_path = Path(".") / "vim/autoload/plug.vim"
    if not vim_plug_path.exists():
        # os.chdir("$HOME/.yadr")
        subprocess.call([
         "curl", "-fLo", str(vim_plug_path), "--create-dirs",
         "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
          ])
    subprocess.call([
            "vim", "--noplugin", "-u",
            str(Path.home())+"/.vim/vimplug.vim", "-N", "\"+set hidden\"",
            "\"+syntax on\"", "+PlugClean!", "+PlugInstall", "+qall"
            ])


def install_prezto():
    print()
    print("Installing Prezto (ZSH Enhancements)...")

    zsh_dir = Path().cwd / "zsh"
    prezto_dir = zsh_dir / "prezto/"
    # install prezto dir and files
    # install_files(prezto_dir)
    subprocess.call(["ln", "-nfs", "$HOME/.yadr/zsh/prezto", "$HOME/.zprezto"])
    install_files(prezto_dir.glob('z*'))
    # Append this line to zshrc to load our customize zsh config
    config_code = "for config_file ($HOME/.yadr/zsh/*.zsh) source $config_file"
    with open("~/.zshrc", "a") as f:
        f.write(config_code)

    print()
    subprocess.call([
        "ln", "-nfs", "$HOME/.yadr/zsh/prezto-override/zpreztorc",
        "$HOME/.zpreztorc"
        ])
    subprocess.call(["git", "submodule", "update", "--init", "--recursive"])


def install_imgur_screenshot():
    cwd = Path.cwd()
    home = Path.home()
    imgur_desk_src = cwd / "bin/imgur_screenshot/imgur_screenshot.desktop"
    imgur_desk_dest = home / ".local/share/applications/"
    imgur_script = cwd / "bin/imgur_screenshot/imgur-screenshot.sh"
    home_bin = home / "bin/"
    print("====================")
    print("Install imgur_screenshot")
    print("====================")
    print(imgur_desk_src, imgur_desk_dest, home_bin)
    if not home_bin.exists():
        home_bin.mkdir()
    try:
        shutil.copy(imgur_desk_src, imgur_desk_dest)
    except Exception as e:
        print(e)
    try:
        shutil.copy(imgur_script, home_bin)
    except Exception as e:
        print(e)
    subprocess.call(["sudo", "update-desktop-database"])


def install_tpm():
    subprocess.call(["mkdir", "-p", "$HOME/.tmux/plugins"])
    subprocess.call([
            "ln", "-s", "$HOME/.yadr/bin/tpm",
            "$HOME/.tmux/plugins/tpm"
            ])


def install_fonts():
    subprocess.call(["fc-cache", "-vf", "~/.fonts"])


def setup_submodules():
    "init submodule and download each of them"

    print("======================================================")
    print("Downloading dotfile submodules...please wait")
    print("======================================================")

    subprocess.call(["git", "submodule", "update", "--init", "--recursive"])
    subprocess.call(["git", "submodule", "update", "--recursive"])
    subprocess.call(["git", "clean", "-df"])


def success_msg():
    print(" |  __ \\      | | |  ____(_) |     ")
    print(" | |  | | ___ | |_| |__   _| | ___ ")
    print(" | |  | |/ _ \\| __|  __| | | |/ _ \\")
    print(" | |__| | (_) | |_| |    | | |  __/")
    print(" |_____/ \\___/ \\__|_|    |_|_|\\___|")
    print("Dotfile has been installed. Please restart your terminal and vim.")


if __name__ == "__main__":
    """Dot files is the set contains dot file pattern as the key,
        and config list as value
    """
    setup_submodules()

    dot_files = {
            "git/*": [],
            "ctags/*": [],
            "tmux/*": [],
            "vimfy/*": [],
            "vim/vimrc": [],
            "vim": [],
            "i3": [],
            "doom.d": [],
            "idea/ideavimrc": [],
            "config/nvim/*": ["symlink", "config"],
            "config/fcitx/rime/*": ["symlink", "config"],
            "fonts/*": ["symlink", "config"]
            }
    p = Path('.')
    for key, config in dot_files.items():
        # unpack config list as argument
        install_files(p.glob(key), *config)
    install_imgur_screenshot()
    install_fonts()
    install_vim_plug()
    success_msg()
