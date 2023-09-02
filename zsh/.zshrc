# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Add .local/bin
export PATH=$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME"/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#7a7a7a'

#GOLANG
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin
export PATH=$PATH:~/go/bin/gopls

#Flutter
export PATH="$PATH:/home/jason/.flutter/bin"
export CHROME_EXECUTABLE="/bin/chromium"


#Android Studio @TODO move this to /usr/local/Android and chown the folder
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

#JAVA
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
export PATH=$JAVA_HOME/bin:$PATH

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# lazy_load_nvm() {
#   unset -f npm node nvm
#   export NVM_DIR=~/.nvm
#   [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
#   [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
# }
#
# npm() {
#   lazy_load_nvm
#   npm $@
# }
#
# node() {
#   lazy_load_nvm
#   node $@
# }
#
# nvm() {
#   lazy_load_nvm
#   nvm $@
# }

# Lua
export PATH=$HOME/lua/src:$PATH

# Tmuxifier
export PATH="$HOME/.config/tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions history-substring-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export EDITOR='hx'

# Aliases
alias :q="exit"
alias lg="lazygit"
alias ld="lazydocker"
alias vim="nvim"
alias dotfiles="cd ~/.dotfiles && vim"
alias vscode="code . && exit"
alias work="cd ~/work/"
alias wiki="cd ~/Mega/vim_wiki && vim"
alias strongbox="~/.strongbox/strongbox"
alias tmx="tmuxifier"

# Function to copy alias's to zshenv file (for nvim/vim cmd to use)
function zshalias()
{
  grep "^alias" ~/.zshrc > ~/.zshenv
}

# Starship
eval "$(starship init zsh)"
