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
mkdir -p ~/.fonts ~/github ~/tests
#####################################################
# SYSTEM ESSENTIALS
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install system essentials? [y/n]"
    echo "( gnome-tweaks, git, vim, make, gcc, curl, ripgrep, gnu stow, xclip, unzip )"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing essentials..."
    echo "------------------------"
    echo
    sudo apt install -y gnome-tweaks vim-runtime vim-gui-common make gcc curl ripgrep xclip stow unzip build-essential
    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# SYSTEM NICETIES
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install system niceties ? [y/n]"
    echo "( tree, neofetch, btop )"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing system niceties..."
    echo "-----------------------------"
    echo
    sudo apt install -y tree neofetch btop
    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# ZSH (Z-SHELL)
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install zsh (z-shell) ? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing zsh..."
    echo "-----------------"
    echo
    sudo apt install -y zsh
    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# OH MY ZSH
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install oh my zsh? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo installing oh my zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    #OH MY ZSH PLUGINS
    if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]]; then
        echo "installing zsh auto suggestion plugin..."
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi

    if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]]; then
        echo "installing zsh syntax highlighting plugin..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    fi

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# STARSHIP
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install Starship? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "Installing starship..."
    echo "------------------"
    echo

    curl -sS https://starship.rs/install.sh | sh
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
# VS CODE
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install Visual Studio Code? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing Visual Studio Code..."
    echo "---------------------------------"
    echo

    download="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    cd ~ && wget -O "vscode.deb" $download

    sudo apt install "./vscode.deb"
    rm vscode.deb

    echo
    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
 echo
#####################################################
# ZOLA STATIC SITE GENERATOR
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install ZOLA static site generator? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "Installing zola..."
    echo "------------------"
    echo

    tag=$(curl --silent https://api.github.com/repos/getzola/zola/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')

    echo $tag

    FILE="zola-"$tag"-x86_64-unknown-linux-gnu.tar.gz"
    echo $FILE

    download="https://github.com/getzola/zola/releases/download/"$tag"/"$FILE
    cd ~ && wget -O $FILE $download

    tar xvf $FILE zola
    sudo mv zola /usr/local/bin/
    rm $FILE

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

    chsh -s $(which zsh)

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# Symlink dot files
#####################################################
if [[ $_override = "n" ]]; then
    echo "Stow(symlink) dotfiles? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "Symlinking dotfiles..."
    echo "----------------------"
    echo
    cd ~/dotfiles/
    sudo rm -rf ~/.vimrc && stow vim
    sudo rm -rf ~/.zshrc && stow zsh
    sudo rm -rf ~/.config/starship.toml && stow starship
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