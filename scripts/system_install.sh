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
mkdir -p ~/.dotfiles ~/.themes ~/.fonts ~/.icons
mkdir -p ~/work ~/github ~/tests
#####################################################
# SYSTEM ESSENTIALS
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install system essentials? [y/n]"
    echo "( git, ripgrep, fzf, gnu stow, xclip )"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing essentials..."
    echo "------------------------"
    echo
    sudo apt install -y ripgrep xclip fzf stow
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
    sudo apt install -y tree neofetch htop
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
fi
#####################################################
# Alacritty
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install Alacritty? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing alacritty..."
    echo "-----------------------"
    echo
    sudo add-apt-repository ppa:aslatter/ppa
    sudo apt update
    sudo apt install -y alacritty
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

    sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker $USER
fi
#####################################################
# DOCKER COMPOSE
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install docker compose? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "Installing docker-compose..."
    echo "----------------------------"
    echo
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod a+x /usr/local/bin/docker-compose
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
    cd ~ && curl -LO https://raw.githubusercontent.com/drud/ddev/master/scripts/install_ddev.sh && bash install_ddev.sh
    sudo wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 -O /usr/local/bin/mkcert
    sudo chmod a+x /usr/local/bin/mkcert
    mkcert -install
    rm install_ddev.sh
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

fi
#####################################################
# @TODO LUA
#####################################################
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

    FILE="zola_"$tag"-x86_64-unknown-linux-gnu.tar.gz"

    download="https://github.com/getzola/zola/releases/download/"$tag"/"$FILE
    cd ~ && wget -O $FILE $download
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
    mv lazygit ~/.lazygit
    rm $FILE
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
    mv lazydocker ~/.lazydocker
    rm $FILE
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

    tag=$(curl --silent https://api.github.com/repos/neovim/neovim/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
    echo $tag

    VERSION=$(echo $tag|cut -c 2-6)
    FILE="nvim.appimage"

    download="https://github.com/neovim/neovim/releases/download/"$tag"/"$FILE
    cd ~ && wget -O $FILE $download

    mkdir -p /home/$USER/.nvim-app
    mv nvim.appimage /home/$USER/.nvim-app/nvim.appimage
    cd /home/$USER/.nvim-app && chmod a+x nvim.appimage

    # Dependencies
    sudo apt install build-essential

    # Setup Packer Quick start here for firs start
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi
#####################################################
# i3
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install i3 window manager? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "Installing i3..."
    echo "----------------"
    echo
    sudo apt install -y i3 picom feh nautilus lxappearance
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

    download="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    cd ~ && wget -O $FILE $download
fi
#####################################################
# MEGA SYNC
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install Mega Sync? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing Mega Sync..."
    echo "-----------------------"
    echo

    FILE="megasync-xUbuntu_22.04_amd64.deb"

    download="https://mega.nz/linux/repo/xUbuntu_22.04/amd64/"$FILE
    cd ~ && wget -O $FILE $download

    # dependencies
    sudo apt install libc-ares2 libmediainfo0v5 libmms0 libtinyxml2-9 libzen0v5

    sudo apt install $FILE
    rm $FILE
fi
#####################################################
# CHROMIUM
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install chromium? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    echo ""
    echo "installing chromium browser..."
    echo "------------------------------"
    echo

    sudo apt install -y chromium-browser
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
    fi
fi
#####################################################
# GRUVBOX GTK THEMES
#####################################################
if [[ $_override = "n" ]]; then
    echo "Install Gruvbox gtk theme? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    if [[ ! -d "${HOME}/.themes/Gruvbox-Material-Dark" ]]; then
        cd ~ && git clone "git@github.com:TheGreatMcPain/gruvbox-material-gtk.git"

        FILE="gruvbox-material-gtk"
        cd ~/$FILE && cp -r themes/* ~/.themes
        cd ~/$FILE && cp -r icons/* ~/.icons

        cd ~ && rm -rf $FILE
    else
        echo "Theme already installed..."
    fi
fi
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

    cd ~/.dotfiles/ && stow i3/ i3status/ nvim/ tmux/ picom/ dunst/ alacritty/ zsh/

    cd ~ && /bin/zsh -c 'source ~/.zshrc && zshalias'

    sudo chsh -s /bin/zsh $USER
fi
