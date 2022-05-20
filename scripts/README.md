# System install script
(Currently tested on Xubuntu 22.04)

initial steps for system install script

* Generate ssh key and copy cat output

```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_rsa

cat ~/.ssh/id_rsa.pub
```

* log into github and add ssh key

* update the system
```
sudo apt update

sudo apt upgrade -y
```

* run the install.sh script

* relog

* run the theme.sh script

* restart terminal and run
```
cd ~ && source ~/.zshrc && zshalias
```

* Install gnome extensions
  - User themes
  - Just perfection
  - Simply Workspaces
  - Window Is Ready - Notification Remover

---
## Software install list:
- Ripgrep
- GNU Stow
- Xclip
- Gnome Tweaks
- Zsh && Oh My Zsh
- Neovim
- Alacritty
- Tmux
- Docker
- Docker Compose
- DDEV
- Volta (nodejs)
- Rust
- Lua
- Transmission
- Lazy Git
- Lazy Docker
- Zola

## Software to be installed manually
- Android Studio
- React Native Sdk
- Flutter Sdk
- Mega
