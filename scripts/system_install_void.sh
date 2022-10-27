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
mkdir -p ~/.themes ~/.fonts ~/.icons
mkdir -p ~/work ~/github ~/tests
#####################################################
# SYSTEM ESSENTIALS
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install system essentials? [y/n]"
    echo "( git, make, gcc, curl, wget, ripgrep, fzf, gnu stow, xclip, unzip)"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing essentials..."
    echo "------------------------"
    echo
    sudo xbps-install -Sy make gcc wget curl ripgrep xclip fzf stow unzip
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
    sudo xbps-install -Sy tree neofetch htop
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
    sudo xbps-install -Sy zsh
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
    sudo xbps-install -Sy tmux
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

	sudo xbps-install -Sy lazydocker
	sudo usermod -aG docker $USER
	#sudo ln -s /etc/sv/docker /var/service

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

    # sudo apt install libnss3-tools -y
    # cd ~ && curl -LO https://raw.githubusercontent.com/drud/ddev/master/scripts/install_ddev.sh && bash install_ddev.sh
    # sudo wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 -O /usr/local/bin/mkcert
    # sudo chmod a+x /usr/local/bin/mkcert
    # rm install_ddev.sh

	# sudo xbps-install -S nss
	#mkcert binary
	# curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64"
	# chmod +x mkcert-v*-linux-amd64
	# sudo cp mkcert-v*-linux-amd64 /usr/local/bin/mkcert
 	# mkcert -install
	#ddev binary
    tag=$(curl --silent https://api.github.com/repos/drud/ddev/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')

    echo $tag

    FILE="ddev_linux-amd64."$tag".tar.gz"
    echo $FILE

    download=" https://github.com/drud/ddev/releases/download/"$tag"/"$FILE
	cd ~ && wget -O $FILE $download

    tar xvf $FILE ddev

	#TODO move to bin
    #mv zola ~/.zola
    #rm $FILE

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# VOLTA(nodejs)
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install volta (node) ? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing volta..."
    echo "-------------------"
    echo
    curl https://get.volta.sh | bash
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
    #sudo apt install default-jre default-jdk -y
	#https://voidlinux.org/packages/?arch=x86_64&q=openjdk11

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

	#TODO move to bin
    mv zola /usr/local/bin/mkcert
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

	sudo xbps-install -Sy lazygit

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


	sudo xbps-install -Sy make gcc neovim fzf
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

	sudo xbps-install -Sy vsv

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# APPLICATIONS
#####################################################
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

	# TODO
	# sudo xbps-install -Sy vscode

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

    sudo xbps-install -Sy transmission

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

    sudo xbps-install -Sy vlc

    echo
    echo "===== COMPLETE ====="
    echo
else
    echo
fi
#####################################################
# THEMES
#####################################################
#####################################################
# FONTS
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install Space Mono Font? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    #SPACE MONO FONT
    font="Space Mono Nerd Font"
    fc-list -q "$font"
    if [ $? -eq 0 ]
    then
        echo "Space Mono Nerd Font found on system moving on..."
    else
        echo "Adding font to system..."

        echo "Downloading Space Mono Nerd Font..."
        wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SpaceMono.zip" -q --show-progress

        if [ -d $HOME"/.fonts/" ]; then
            unzip -q "./SpaceMono.zip" -d $HOME"/.fonts/"
        else
           mkdir -p $HOME"/.fonts/"
           unzip -q "./SpaceMono.zip" -d $HOME"/.fonts/"
        fi

        echo "Cleaning up download..."
        rm -rf "./SpaceMono.zip"

        echo
        echo "===== COMPLETE ====="
        echo
    fi
else
    echo
fi
#####################################################
# @TODO paparius adwaita
#####################################################
#####################################################
# STOW DOTFILES
#####################################################
if [[ $_override = "n" ]]; then
    echo "Link dot files with stow? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    cd ~ && rm -rf .config/i3 .config/i3status .config/nvim ~/.tmux.conf .config/picom .config/dunst .config/alacritty .zshrc

    cd ~/.dotfiles/ && stow  nvim/ tmux/ zsh/

    cd ~ && /bin/zsh -c 'source ~/.zshrc && zshalias'

    sudo chsh -s /bin/zsh $USER
fi

echo
echo "===== SYSTEM INSTALL COMPLETE ====="
echo
