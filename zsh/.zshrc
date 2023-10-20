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

# GOLANG
#export PATH=$PATH:/usr/local/go/bin
#export PATH=$PATH:~/go/bin
#export PATH=$PATH:~/go/bin/gopls

# Nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init - zsh)"

# Phpenv functions
lp7 () {
    sudo a2dismod php8.2
    sudo a2enmod php7.4
    sudo update-alternatives --set php /usr/bin/php7.4
    sudo systemctl restart apache2
}
lp8 () {
    sudo a2dismod php7.4
    sudo a2enmod php8.2
    sudo update-alternatives --set php /usr/bin/php8.2
    sudo systemctl restart apache2
}
# aliases
alias load_php8='load_php8'
alias load_php7='load_php7'

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
alias composer="~/.local/bin/composer.phar"
alias nvim="~/.local/bin/nvim/bin/nvim -u ~/personal/nvim_new/init.lua"
alias vim="~/.local/bin/nvim/bin/nvim"
alias dotfiles="cd ~/dotfiles && vim"
alias wiki="cd ~/Mega/vim_wiki && vim index.md"
alias tmx="tmuxifier"

# Work directories quick aliases
alias rep="cd /eyona/web/repforce.co/dev.secure"
alias lms="cd /eyona/web/lms.co/lms"

# Starship
eval "$(starship init zsh)"
