linux dotfiles managed with stow
--------------------------------

install GNU Stow
```
sudo apt install stow
```

Clean install steps:

```
cd ~

git clone git@github.com:JSONhilder/dotfiles.git

cd ~/dotfiles

stow zsh/ tmux/ alacritty/ nvim/
```
