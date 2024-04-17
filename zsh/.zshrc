# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Add .local/bin
export PATH=$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME"/.oh-my-zsh"

export EDITOR="nvim"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#7a7a7a'

# Better colors for write enabled files
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"

# GOLANG
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin
export PATH=$PATH:~/go/bin/gopls

# Zig
export PATH="/usr/local/zig:$PATH"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

alias vim="/usr/local/bin/nvim"

# Aliases
alias :q="exit"
alias lg="lazygit"
alias gu="gitui"
alias ld="lazydocker"
alias composer="~/.local/bin/composer.phar"
alias dotfiles="cd ~/dotfiles && vim"
alias wiki="cd ~/Mega/vim_wiki && vim index.md"

# Starship
eval "$(starship init zsh)"
