#!/bin/bash

function install_package() {
    local package_name=$1
    local package_install_cmd=$2

    echo "Install $package_name? [y/n]"
    read _proceed
    _proceed=${_proceed,,}

    if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
        echo ""
        echo "Installing $package_name..."
        echo "-------------------------"
        echo

        eval "$package_install_cmd"

        echo
        echo "===== COMPLETE ====="
        echo
    else
        echo
    fi
}

echo "Install everything or select options? [y/n]"
read _override
_override=${_override,,}

if [[ $_override != "y" ]] && [[ $_override != "yes" ]]; then
    _override="n"
fi

#####################################################
# SYSTEM SOFTWARE
#####################################################
mkdir -p ~/.themes ~/.fonts ~/.icons
mkdir -p ~/work ~/github ~/tests

#####################################################
# SYSTEM ESSENTIALS
#####################################################
if [[ $_override = "n" ]]; then
    install_package "system essentials (git, make, gcc, curl, ripgrep, fzf, gnu stow, xclip, unzip)" \
    "sudo apt install -y make gcc curl ripgrep xclip fzf stow unzip build-essential"
fi

#####################################################
# SYSTEM NICETIES
#####################################################
if [[ $_override = "n" ]]; then
    install_package "system niceties (tree, neofetch, htop)" \
    "sudo apt install -y tree neofetch htop"
fi

#####################################################
# ZSH (Z-SHELL)
#####################################################
if [[ $_override = "n" ]]; then
    install_package "zsh (z-shell)" \
    "sudo apt install -y zsh"
fi

#####################################################
# TMUX
#####################################################
if [[ $_override = "n" ]]; then
    install_package "tmux" \
    "sudo apt install -y tmux"
fi

#####################################################
# DOCKER ENGINE
#####################################################
if [[ $_override = "n" ]]; then
    install_package "docker" \
    'sudo apt-get remove docker docker.io containerd runc; sudo apt-get install -y ca-certificates curl gnupg lsb-release; sudo mkdir -p /etc/apt/keyrings; curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg; echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null; sudo apt update; sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin; sudo usermod -aG docker $USER'
fi

#####################################################
# DDEV
#####################################################
if [[ $_override = "n" ]]; then
    install_package "ddev" \
    'sudo apt install libnss3-tools -y; sudo wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 -O /usr/local/bin/mkcert; sudo chmod a+x /usr/local/bin/mkcert; mkcert -install; tag=$(curl --silent https://api.github.com/repos/drud/ddev/releases/latest | grep -Po '"'"'"tag_name"'"'"': '"'"'"\K.*?(?="'"'"'")'"'"'); FILE="ddev_linux-amd64."$tag".tar.gz"; download="https://github.com/drud/ddev/releases/download/"$tag"/"$FILE; cd ~ && wget -O $FILE $download; tar xvf $FILE ddev; sudo mv ddev /usr/local/bin/ddev; rm $FILE'
fi

#####################################################
# VOLTA (nodejs)
#####################################################
if [[ $_override = "n" ]]; then
    install_package "volta (node)" \
    'curl https://get.volta.sh | bash'
fi

#####################################################
# RUST LANG
#####################################################
if [[ $_override = "n" ]]; then
    install_package "Rust" \
    'curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh'
fi

#####################################################
# JDK
#####################################################
if [[ $_override = "n" ]]; then
    install_package "Java Development Kit" \
    'sudo apt install default-jre default-jdk -y'
fi

#####################################################
# FLUTTER
#####################################################
if [[ $_override = "n" ]]; then
    install_package "Flutter SDK" \
    'cd ~ && git clone https://github.com/flutter/flutter.git -b stable'
fi

#####################################################
# ZOLA STATIC SITE GENERATOR
#####################################################
if [[ $_override = "n" ]]; then
    install_package "ZOLA static site generator" \
    'tag=$(curl --silent https://api.github.com/repos/getzola/zola/releases/latest | grep -Po '"'"'"tag_name"'"'"': '"'"'"\K.*?(?="'"'"'")'"'"'); FILE="zola-"$tag"-x86_64-unknown-linux-gnu.tar.gz"; download="https://github.com/getzola/zola/releases/download/"$tag"/"$FILE; cd ~ && wget -O $FILE $download; tar xvf $FILE zola; sudo mv zola ~/.local/bin/; rm $FILE'
fi

#####################################################
# LAZYGIT
#####################################################
if [[ $_override = "n" ]]; then
    install_package "Lazy Git" \
    'tag=$(curl --silent https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -Po '"'"'"tag_name"'"'"': '"'"'"\K.*?(?="'"'"'")'"'"'); VERSION=$(echo $tag|cut -c 2-6); FILE="lazygit_"$VERSION"_Linux_x86_64.tar.gz"; download="https://github.com/jesseduffield/lazygit/releases/download/"$tag"/"$FILE; cd ~ && wget -O $FILE $download; tar xvf $FILE lazygit; sudo mv lazygit /usr/local/bin/lazygit; rm $FILE'
fi

#####################################################
# LAZYDOCKER
#####################################################
if [[ $_override = "n" ]]; then
    install_package "Lazy Docker" \
    'tag=$(curl --silent https://api.github.com/repos/jesseduffield/lazydocker/releases/latest | grep -Po '"'"'"tag_name"'"'"': '"'"'"\K.*?(?="'"'"'")'"'"'); VERSION=$(echo $tag|cut -c 2-7); FILE="lazydocker_"$VERSION"_Linux_x86_64.tar.gz"; download="https://github.com/jesseduffield/lazydocker/releases/download/"$tag"/"$FILE; cd ~ && wget -O $FILE $download; tar xvf $FILE lazydocker; sudo mv lazydocker /usr/local/bin/lazydocker; rm $FILE'
fi

#####################################################
# NEOVIM
#####################################################
if [[ $_override = "n" ]]; then
    install_package "Neovim" \
    'tag=$(curl --silent https://api.github.com/repos/neovim/neovim/releases/latest | grep -Po '"'"'"tag_name"'"'"': '"'"'"\K.*?(?="'"'"'")'"'"'); VERSION=$(echo $tag|cut -c 2-6); FILE="nvim.appimage"; download="https://github.com/neovim/neovim/releases/download/"$tag"/"$FILE; cd ~ && wget -O $FILE $download; sudo mv nvim.appimage /usr/local/bin/nvim; cd /usr/local/bin && chmod a+x nvim; git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim'
fi

#####################################################
# OH MY ZSH
#####################################################
if [[ $_override = "n" ]]; then
    install_package "Oh My Zsh" \
    'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]]; then git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions; fi; if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]]; then git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting; fi'
fi

#####################################################
# APPLICATIONS
#####################################################

#####################################################
# Visual Studio Code
#####################################################
if [[ $_override = "n" ]]; then
    install_package "Visual Studio Code" \
    'download="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"; cd ~ && wget -O "vscode.deb" $download; sudo apt install "./vscode.deb"; rm vscode.deb'
fi

#####################################################
# TRANSMISSION
#####################################################
if [[ $_override = "n" ]]; then
    install_package "Transmission" \
    'sudo apt install -y transmission'
fi

#####################################################
# VLC
#####################################################
if [[ $_override = "n" ]]; then
    install_package "VLC media player" \
    'sudo apt install -y vlc'
fi

#####################################################
# THEMES
#####################################################

#####################################################
# Fonts
#####################################################
if [[ $_override = "n" ]]; then
    install_package "Space Mono Font" \
    'font="Space Mono Nerd Font"; fc-list -q "$font"; if [ $? -ne 0 ]; then wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SpaceMono.zip" -q --show-progress; if [ -d $HOME"/.fonts/" ]; then unzip -q "./SpaceMono.zip" -d $HOME"/.fonts/"; else mkdir -p $HOME"/.fonts/"; unzip -q "./SpaceMono.zip" -d $HOME"/.fonts/"; fi; rm -rf "./SpaceMono.zip"; fi'
fi

#####################################################
# STOW DOTFILES
#####################################################
if [[ $_override = "n" ]]; then
    install_package "Stow Dotfiles" \
    'cd ~ && rm -rf .config/i3 .config/i3status .config/nvim ~/.tmux.conf .config/picom .config/dunst .config/alacritty .zshrc; cd ~/.dotfiles/ && stow i3/ i3status/ nvim/ tmux/ picom/ dunst/ alacritty/ zsh/ htop/; cd ~ && /bin/zsh -c "source ~/.zshrc && zshalias"; sudo chsh -s /bin/zsh $USER'
fi

echo
echo "===== SYSTEM INSTALL COMPLETE ====="
echo

