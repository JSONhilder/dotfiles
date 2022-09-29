Dotfiles :)
--------------------------------

![Preview Image of system1](https://github.com/jasonhilder/dotfiles/blob/main/preview-1.png)
![Preview Image of system2](https://github.com/jasonhilder/dotfiles/blob/main/preview-2.png)

### Replicate Setup

Currently used with the Pop_os desktop environment

Initial steps ***before*** system install script

### Update the system
```
sudo apt update

sudo apt upgrade -y
```
Reboot

### Install git (only needed if selected minimal install)
```
sudo apt install git
```

### Configure git global user
```
git config --global user.name "FIRST_NAME LAST_NAME"

git config --global user.email "MY_NAME@example.com"
```

### Generate ssh key and copy cat output
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_rsa

cat ~/.ssh/id_rsa.pub
```

### Log into github and add ssh key

### Clone this repository
```
git clone git@github.com:jasonhilder/dotfiles.git && mv dotfiles ~/.dotfiles
```

### Run the install.sh script (note: dont use sudo for this.)
```
bash /path/to/system_install.sh
```

### Reboot

## Software install list:
- Git
- make
- gcc
- build-essential
- Ripgrep (rg)
- gnu Stow
- xclip
- unzip
- fzf
- tree
- neofetch
- htop
- zsh && Oh My Zsh
- Alacritty
- Docker
- Docker Compose
- DDEV
- Volta (nodejs)
- Rust
- jdk-11
- Flutter
- Zola
- Lazy Git
- Lazy Docker
- Neovim
- tmux
- i3
- dunst
- Vscode
- Mega
- Transmission
- vlc
- fonts

## Software to be installed manually
- Android Studio

---

## Symlinking Dotfiles Manually

install GNU Stow
```
sudo apt install stow
```

Clean install steps:

```
cd ~

git clone git@github.com:jasonhilder/dotfiles.git && mv dotfiles ~/.dotfiles

cd ~/.dotfiles

stow zsh/ tmux/ alacritty/ nvim/ ...
```

For vim/nvim to have access to aliases after symlinking the .zshrc file run:
```
source ~/.zshrc && zshalias
```
