# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Add .local/bin
export PATH=$HOME/.local/bin:$PATH

# Add snap/bin
export PATH=$PATH:/snap/bin

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

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

# Aliases
alias :q="exit"
#alias lg="lazygit"
alias lg="vim +Neogit"
alias gitc="vim +Neogit"
alias gu="gitui"
alias ld="lazydocker"
alias composer="~/.local/bin/composer.phar"
alias vim="~/.local/bin/nvim/bin/nvim"
alias dotfiles="cd ~/dotfiles && vim"
alias wiki="cd ~/Mega/vim_wiki && vim index.md"

# Work directories quick aliases
alias rep="cd /eyona/web/repforce.co/dev.secure"
alias lms="cd /eyona/web/lms.co/lms"

# Starship
eval "$(starship init zsh)"
