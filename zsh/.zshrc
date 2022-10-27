# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/jason/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="af-magic"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#7a7a7a'

#GOLANG
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin

#Flutter
export PATH="$PATH:/home/jason/flutter/bin"

#Android Studio
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

#
path+=('~/.local/bin')

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions history-substring-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

# Aliases
alias vim="nvim"
alias v="nvim"
alias wiki="cd ~ && nvim -c 'VimwikiIndex'"
alias ra="ranger ."
alias vscode="code . && exit"
alias strongbox="~/.strongbox/strongbox"
alias work="cd ~/work/"
alias :q="exit"

# Function to copy alias's to zshenv file (for nvim/vim cmd to use)
function zshalias()
{
  grep "^alias" ~/.zshrc > ~/.zshenv
}
