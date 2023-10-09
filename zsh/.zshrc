# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Add .local/bin
export PATH=$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME"/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#7a7a7a'

# Better colors for write enabled files
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"

#GOLANG
#export PATH=$PATH:/usr/local/go/bin
#export PATH=$PATH:~/go/bin
#export PATH=$PATH:~/go/bin/gopls

# Node version manager
export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# lazy_load_nvm() {
#     unset -f npm node nvm
#     export NVM_DIR=~/.nvm
#     [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
#     [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
# }
#
# npm() {
#     lazy_load_nvm
#     npm $@
# }
#
# node() {
#     lazy_load_nvm
#     node $@
# }
#
# nvm() {
#     lazy_load_nvm
#     nvm $@
# }

# Lua
# export PATH=$HOME/lua/src:$PATH

# Tmuxifier
#export PATH="$HOME/.config/tmuxifier/bin:$PATH"
#eval "$(tmuxifier init -)"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# wtf is this ? -> history-substring-search
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

# Aliases
alias :q="exit"
alias lg="lazygit"
alias ld="lazydocker"
alias nvim="~/.local/bin/nvim/bin/nvim"
alias vim="~/.local/bin/nvim/bin/nvim"
alias dotfiles="cd ~/dotfiles && vim"
alias wiki="cd ~/Mega/vim_wiki && vim index.md"
alias tmx="tmuxifier"

# Work dir quick aliases
alias rep="cd /eyona/web/repforce.co/dev.secure"
alias lms="cd /eyona/web/lms.co/lms"

# Function to copy alias's to zshenv file (for nvim/vim cmd to use)
function zshalias()
{
  grep "^alias" ~/.zshrc > ~/.zshenv
}

# Starship
eval "$(starship init zsh)"
