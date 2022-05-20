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
# SYNC DOTFILES
#####################################################
if [[ $_override = "n" ]]; then
    echo "Syn dotfiles from github? [y/n]"
    read _proceed
    # lowercase it
    _proceed=${_proceed,,}
fi

if [[ $_proceed = "y" ]] || [[ $_proceed = "yes" ]]; then
    if [ ! -d ~/.dotfiles/ ]; then
       eval "$(ssh-agent -s)"
       ssh-add /home/$LOCALUSR/.ssh/id_rsa
       cd /home/$LOCALUSR && git clone git@github.com:jasonhilder/dotfiles.git
       mv /home/$LOCALUSR/dotfiles /home/$LOCALUSR/.dotfiles
       cd /home/$LOCALUSR/.dotfiles && stow zsh/ tmux/ alacritty/ nvim/
       cd /home/$LOCALUSR
    fi
