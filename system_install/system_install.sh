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
    echo "( git, vim, make, gcc, curl, wget, ripgrep, xclip, unzip, tree, btop, neofetch )"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing essentials..."
    echo "------------------------"
    echo
    sudo apt install -y git make gcc curl wget ripgrep xclip unzip build-essential tree btop neofetch
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
# LAZYGIT
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install Lazy Git? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "Installing lazygit..."
    echo "---------------------"
    echo

    tag=$(curl --silent https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')

    echo $tag

    VERSION=$(echo $tag|cut -c 2-7)
    FILE="lazygit_"$VERSION"_Linux_x86_64.tar.gz"

    

    download="https://github.com/jesseduffield/lazygit/releases/download/"$tag"/"$FILE
    cd ~ && wget -O $FILE $download

    tar xvf $FILE lazygit
    sudo mv lazygit /usr/local/bin/lazygit
    rm $FILE

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
    echo "Set default shell to zshell? [y/n]"
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
