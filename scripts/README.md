# System install script
(Currently tested on Xubuntu 22.04)

Initial steps for system install script

### update the system
```
sudo apt update

sudo apt upgrade -y
```
Reboot

### Install git (only needed if selected minimal install)
```
sudo apt install git
```

### Generate ssh key and copy cat output
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_rsa

cat ~/.ssh/id_rsa.pub
```
### log into github and add ssh key

### clone this repository
```
git clone git@github.com:jasonhilder/dotfiles.git && mv dotfiles ~/.dotfiles
```

### run the install.sh script (note: dont use sudo for this.)
```
./path/to/system_install.sh
```

### relog

### run the theme.sh script

### restart terminal and run
```
cd ~ && source ~/.zshrc && zshalias
```

---
## Software install list:
- Git
- Ripgrep
- GNU Stow
- Xclip
- fzf
- lxappearance
- i3
- dunst
- picom
- Zsh && Oh My Zsh
- Neovim
- Alacritty
- Tmux
- Docker
- Docker Compose
- DDEV
- Volta (nodejs)
- Rust
- Flutter
- Lua
- Transmission
- chromium
- vlc
- Lazy Git
- Lazy Docker
- Zola
- Mega
- Vscode (Deb needs to be installed manually)

## Software to be installed manually
- Android Studio
- React Native Sdk
