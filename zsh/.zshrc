# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Add .local/bin
export PATH=$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME"/.oh-my-zsh"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo

# Load completions
autoload -Uz compinit && compinit

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias c='clear'


# ------------------------------------------------------------------------
# ------------------------------------------------------------------------
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
export PATH="/home/jason/.zig:$PATH"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

alias vi="/usr/bin/nvim/bin/nvim"

# Aliases
alias ..="cd .."
alias :q="exit"
alias lg="lazygit"
alias gu="gitui"
alias ld="lazydocker"
alias composer="~/.local/bin/composer.phar"
alias dotfiles="cd ~/dotfiles && vim"
alias wiki="cd ~/Mega/vim_wiki && vim index.md"

# Starship
eval "$(starship init zsh)"
