#!/bin/bash
echo "Syncing void repositories..."
echo "------------------------"
echo
sudo xbps-install -S
echo
echo "===== COMPLETE ====="
echo ""
echo ""

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
mkdir -p ~/work ~/github ~/tests ~/.local/bin

#####################################################
# SYSTEM ESSENTIALS
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install system essentials? [y/n]"
    echo "( make, gcc, curl, wget, ripgrep, fzf, gnu stow, xclip, unzip, zip)"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing essentials..."
    echo "------------------------"
    echo
    sudo xbps-install -y make gcc wget curl ripgrep xclip fzf stow unzip zip
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
    echo "( tree, neofetch, htop )"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing system niceties..."
    echo "-----------------------------"
    echo
    sudo xbps-install -y tree neofetch htop
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
    sudo xbps-install -y tmux
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
    echo "Install docker and lazydocker? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi
if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing docker..."
    echo "--------------------"
    echo

	sudo xbps-install -y docker
	sudo xbps-install -y lazydocker
    # add user
	sudo usermod -aG docker $USER
    # link service for startup
	sudo ln -s /etc/sv/docker /var/service

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

    # nss depedency
	# sudo xbps-install -y nss
	# mkcert binary
	curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64"
	chmod +x mkcert-v*-linux-amd64
	sudo mv mkcert-v*-linux-amd64 /usr/local/bin/

	# ddev binary
    curl -LO https://raw.githubusercontent.com/ddev/ddev/master/scripts/install_ddev.sh && bash install_ddev.sh v1.22.0-alpha2

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
# JDK
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install Java Development Kit 11? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "Installing Java Dev Kit..."
    echo "--------------------------"
    echo
    sudo xbps-install -y openjdk11
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

    cd ~ && git clone https://github.com/flutter/flutter.git -b stable && mv fluter .flutter
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

	#TODO move to bin
    mv zola /usr/local/bin
    rm $FILE

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi

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

	sudo xbps-install -y make gcc neovim fzf

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
    sudo xbps-install -y zsh
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
# VSV
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install vsv? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo vsv
    echo

	sudo xbps-install -y vsv

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# Rofi launcher
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install rofi launcher? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing Rofi launcher..."
    echo "--------------------------"
    echo

    sudo xbps-install -y rofi

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi

#####################################################
# Nix package manager
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install Nix Package Manager? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing Nix Package manager..."
    echo "--------------------------"
    echo

    sudo xbps-install -y nix
    sudo ln -s /etc/sv/nix-daemon /var/service

    source /etc/profile

    nix-channel --add http://nixos.org/channels/nixpkgs-unstable
    nix-channel --update

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi

#####################################################
# APPLICATIONS
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

    sudo xbps-install -y transmission

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

    sudo xbps-install -y vlc

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

    sudo chsh -s $(which zsh)

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
    sudo rm -rf ~/.zshrc && stow ~/.dotfiles/zsh/
    sudo rm -rf ~/.config/nvim && stow ~/.dotfiles/nvim
    sudo rm -rf ~/.tmux.conf && stow ~/.dotfiles/tmux
    sudo rm -rf ~/.config/lf && stow ~/.dotfiles/lf
    sudo rm -rf ~/.config/tmuxifier/layouts && stow ~/.dotfiles/tmuxifier
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
