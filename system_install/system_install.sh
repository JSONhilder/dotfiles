#!/bin/bash
echo "Install everything or select options? [y/n]"
echo ""
echo "Note: If you type n (no) you will be asked before each install to proceed."

# _override will hold the input value
read _override

# lowercase it
_override=${_override,,}

if [[ $_override = "y" ]] || [[ $_override = "yes" ]]; then
    # check _override if its yes globally set _proceed
    _proceed="y"
else
    if [[ $_override = "n" ]] || [[ $_override = "no" ]]
    then :
        _override="n"
    else
        echo "Invalid input."
        exit 0
    fi
fi
#####################################################
# CREATE DIRECTORIES IF NOT EXIST
#####################################################
mkdir -p ~/.fonts ~/github 
#####################################################
# SYSTEM ESSENTIALS
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install system essentials? [y/n]"
    echo "( git, neovim, curl, wget, ripgrep, xclip, unzip, tree, btop, neofetch )"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing essentials..."
    echo "------------------------"
    echo
    sudo apt install -y git neovim curl wget ripgrep xclip unzip tree btop neofetch

    git config --global user.name "Jason Hilder"
    git config --global user.email "jhilder95@gmail.com"

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# C Tools
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install C language tools? [y/n]"
    echo "( gcc, make, cmake, clangd, build-essential )"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing essentials..."
    echo "------------------------"
    echo
    sudo apt install -y gcc make cmake clangd build-essential 
    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# Xmake
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install Xmake? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "Installing Xmake..."
    echo "------------------------------"
    echo

    wget https://xmake.io/shget.text -O - | bash

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# Fish Shell
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install fish shell ? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing fish..."
    echo "-----------------"
    echo
    sudo apt install -y fish
    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# I3 Window manager
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install i3 window manager? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing i3..."
    echo "-----------------"
    echo

    sudo apt install dmenu
    sudo apt install i3
    sudo apt install picom
    sudo apt install i3status

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# DOCKER ENGINE
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install docker? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi
if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing docker..."
    echo "--------------------"
    echo

    sudo apt-get remove docker docker.io containerd runc

    sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

    sudo mkdir -p /etc/apt/keyrings

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
    sudo usermod -aG docker $USER

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# LAZYDOCKER
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install Lazy Docker? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "Installing lazydocker..."
    echo "------------------------"
    echo

    tag=$(curl --silent https://api.github.com/repos/jesseduffield/lazydocker/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')

    echo $tag

    VERSION=$(echo $tag|cut -c 2-7)
    FILE="lazydocker_"$VERSION"_Linux_x86_64.tar.gz"

    download="https://github.com/jesseduffield/lazydocker/releases/download/"$tag"/"$FILE
    cd ~ && wget -O $FILE $download

    tar xvf $FILE lazydocker
    sudo mv lazydocker /usr/local/bin/lazydocker
    rm $FILE

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# TRANSMISSION
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install transmission? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing transmission..."
    echo "--------------------------"
    echo

    sudo apt install -y transmission

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# VLC
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install vlc media player? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing vlc media player..."
    echo "------------------------------"
    echo

    sudo apt install -y vlc

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# SET SHELL
#####################################################
if [[ $_override = "n" ]]; then
    echo "Set default shell to fish? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "Setting zsh as default shell..."
    echo "------------------------------"
    echo

    chsh -s $(which fish)

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# Librewolf
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install Librewolf browser (removes firefox)? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "Installing Librewolf browser..."
    echo "-------------------------------"
    echo

    sudo snap remove --purge firefox
    sudo apt update && sudo apt install extrepo -y
    sudo apt upgrade -y
    sudo apt update && sudo apt install librewolf -y

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# REBOOT OPTION
#####################################################
if [[ $_override = "n" ]]; then
    echo "Reboot system? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    sudo reboot
else
    echo
fi
