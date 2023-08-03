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
# SYSTEM SOFTWARE
#####################################################
# CREATE DIRECTORIES IF NOT EXIST
#####################################################
mkdir -p ~/.themes ~/.fonts
mkdir -p ~/work ~/github ~/tests
#####################################################
# SYSTEM ESSENTIALS
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install system essentials? [y/n]"
    echo "( git, make, gcc, curl, ripgrep, fzf, gnu stow, xclip, unzip)"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing essentials..."
    echo "------------------------"
    echo
    sudo apt install -y make gcc curl ripgrep xclip fzf stow unzip build-essential
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
    echo "( tree, neofetch, btop, lf)"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing system niceties..."
    echo "-----------------------------"
    echo
    sudo apt install -y tree neofetch btop lf
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
# TMUX 
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install tmux? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi
if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing tmux..."
    echo "------------------"
    echo
    sudo apt install -y tmux
    git clone https://github.com/jimeh/tmuxifier.git ~/.config/tmuxifier
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
# DDEV
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install ddev? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "Installing ddev deps..."
    echo "-----------------------"
    echo

    sudo apt install libnss3-tools -y
    sudo wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 -O /usr/local/bin/mkcert
    sudo chmod a+x /usr/local/bin/mkcert
    mkcert -install

    tag=$(curl --silent https://api.github.com/repos/drud/ddev/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')

    echo $tag

    FILE="ddev_linux-amd64."$tag".tar.gz"
    echo $FILE

    download=" https://github.com/drud/ddev/releases/download/"$tag"/"$FILE
	cd ~ && wget -O $FILE $download

    tar xvf $FILE ddev

    sudo mv ddev /usr/local/bin/ddev
    #rm $FILE

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# NVM(nodejs)
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install NVM (node) ? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing NVM..."
    echo "-------------------"
    echo
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# RUST LANG
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install Rust? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "Installing rust..."
    echo "------------------"
    echo

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# GOLANG
#####################################################

#####################################################
# JDK
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install Java Development Kit? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "Installing Java Dev Kit..."
    echo "--------------------------"
    echo
    sudo apt install default-jre default-jdk -y
    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# FLUTTER
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install Flutter Sdk? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "Installing Flutter Sdk..."
    echo "-------------------------"
    echo

    cd ~ && git clone https://github.com/flutter/flutter.git -b stable
    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
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
    sudo rm ~/.local/bin/bin/zola
    sudo mv zola ~/.local/bin/
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

    VERSION=$(echo $tag|cut -c 2-6)
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
# HELIX
#####################################################

#####################################################
# NEOVIM
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install Neovim? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "Installing neovim..."
    echo "--------------------"
    echo

    tag=$(curl --silent https://api.github.com/repos/neovim/neovim/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
    echo $tag

    VERSION=$(echo $tag|cut -c 2-6)
    FILE="nvim.appimage"

    download="https://github.com/neovim/neovim/releases/download/"$tag"/"$FILE
    cd ~ && wget -O $FILE $download

    sudo mv nvim.appimage /usr/local/bin/nvim
    cd /usr/local/bin && chmod a+x nvim

    # Setup Packer Quick start here for firs start
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

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
    cd ~/.dotfiles/
    sudo rm -rf ~/.zshrc && stow ~/.dotfiles/zsh/
    sudo rm -rf ~/.tmux.conf && stow ~/.dotfiles/tmux
    sudo rm -rf ~/.config/lf && stow ~/.dotfiles/lf
    sudo rm -rf ~/.config/starship.toml && stow ~/.dotfiles/starship
    sudo rm -rf ~/.config/tmuxifier/layouts && stow ~/.dotfiles/tmuxifier
    sudo rm -rf ~/.config/helix && stow ~/.dotfiles/helix
    sudo mkdir -p ~/.local/bin/ && stow ~/.dotfiles/scripts
    #sudo rm -rf ~/.config/nvim && stow ~/.dotfiles/nvim
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

