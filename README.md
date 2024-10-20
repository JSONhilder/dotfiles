Dotfiles :)
--------------------------------

![Preview Image of system1](/screenshots/preview-1.png)
![Preview Image of system2](/screenshots/preview-2.png)

Steps To Reproduce
---

### ( !! Note this is intended for Xubuntu with i3 !! )

### Git clone dotfiles
```
cd ~ && git clone git@github.com:jasonhilder/dotfiles.git 
```

### Run install script
```
cd ~ && ./dotfiles/system_install.sh
```
*The script will prompt for install of following:*

    - git
    - curl 
    - wget
    - ripgrep
    - xclip
    - unzip
    - tree
    - btop
    - neofetch
    - neovim 
    - gcc
    - make
    - cmake 
    - clangd 
    - build-essential 
    - xmake
    - fish
    - i3
    - i3 status
    - docker
    - lazy docker
    - transmission
    - vlc player
    - librewolf browser

### Stow (symlink) the config files

```
cd ~/dotfiles
rm -rf ~/.config/fish && stow fish
rm -rf ~/.config/i3 && stow i3
rm -rf ~/.config/i3status && stow i3status
rm -rf ~/.config/nvim && stow nvim
rm -rf ~/.local/share/xfce/terminal && stow xfce4term
```
