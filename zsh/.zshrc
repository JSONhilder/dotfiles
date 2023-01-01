# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME"/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#7a7a7a'

#GOLANG
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin

#Flutter
export PATH="$PATH:/home/jason/flutter/bin"

#Android Studio @TODO move this to /usr/local/Android and chown the folder
export ANDROID_HOME=$HOME/.Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

#Volta (node)
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Lua
export PATH=$HOME/lua/src:$PATH

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions history-substring-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export EDITOR='hx'

# Aliases
alias :q="exit"
alias v="nvim"
alias h="hx"
alias lg="lazygit"
alias ld="lazydocker"
alias vim="nvim"
alias dots="cd ~/.dotfiles && h"
alias vscode="code . && exit"
alias work="cd ~/work/"
alias wiki="h ~/Mega/docs"
alias strongbox="~/.strongbox/strongbox"

# Function to copy alias's to zshenv file (for nvim/vim cmd to use)
function zshalias()
{
  grep "^alias" ~/.zshrc > ~/.zshenv
}

# bun completions
[ -s "/home/jason/.bun/_bun" ] && source "/home/jason/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
