# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME"/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#7a7a7a'

#GOLANG
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin

#Flutter
export PATH="$PATH:/home/jason/flutter/bin"

#Android Studio @TODO move this to /usr/local/Android and chown the folder
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

#JAVA
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

#Volta (node)
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Lua
export PATH=$HOME/lua/src:$PATH

# Nim
export PATH=/home/jason/.nimble/bin:$PATH

# Tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions history-substring-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

# Aliases
alias :q="exit"
alias v="nvim"
alias h="hx"
alias lg="lazygit"
alias ld="lazydocker"
alias vim="nvim"
alias dots="cd ~/.dotfiles && v"
alias vscode="code . && exit"
alias work="cd ~/work/"
alias wiki="nvim -c ':VimwikiDiaryIndex'"
alias strongbox="~/.strongbox/strongbox"
alias tmx="tmuxifier"

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
