# ------------------------
# GLOBALS
# ------------------------
set -g fish_greeting

set -x EDITOR vim
set -x MANPAGER "vim +Man!"
set -x TERM xterm-256color

# ------------------------
# PATHS
# ------------------------
set -x PATH $HOME/bin /usr/local/bin $PATH

# Add .local/bin
set -x PATH $HOME/.local/bin $PATH

# GOLANG
set -x PATH /usr/bin/go/bin $PATH
set -x PATH $HOME/go/bin $PATH
set -x PATH $HOME/go/bin/gopls $PATH

# C3
set -x PATH $HOME/.local/bin/c3 $PATH

# Odin
set -x PATH $HOME/.local/share/Odin $PATH

# ------------------------
# ALIASES
# ------------------------
alias .. "cd .."
alias :q exit
alias lg lazygit
alias g gitu
alias ld lazydocker
alias composer "~/.local/bin/composer.phar"
alias dotfiles "cd ~/dotfiles; vim"
alias wiki "cd ~/github/reimagined_barnacle; vim"
alias voidpackages "cd ~/.local/share/pkgs/void-packages"
alias vp "cd ~/.local/share/pkgs/void-packages"

# Dracula Color Palette
set -l foreground ebdbb2
set -l selection 504945
set -l comment 8f3f71
set -l red fb4934
set -l orange fe8019
set -l yellow fabd2f
set -l green b8bb26
set -l purple d3869b
set -l cyan 8ec07c
set -l blue 83a598

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $blue
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $blue
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
