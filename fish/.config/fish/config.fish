# ------------------------
# GLOBALS
# ------------------------
set -g fish_greeting

set -x EDITOR "nvim"
set -x MANPAGER "nvim +Man!"

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

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# C3
set -x PATH $HOME/.local/bin/c3 $PATH

# ------------------------
# ALIASES
# ------------------------
alias .. "cd .."
alias :q "exit"
alias lg "lazygit"
alias g "gitu"
alias ld "lazydocker"
alias composer "~/.local/bin/composer.phar"
alias dotfiles "cd ~/dotfiles; vim"
alias wiki "cd ~/github/reimagined_barnacle; vim"
alias voidpackages "cd ~/.local/share/pkgs/void-packages"
alias vp "cd ~/.local/share/pkgs/void-packages"

# Kanagawa Fish shell theme
set -l foreground DCD7BA normal
set -l selection 2D4F67 brcyan
set -l comment 727169 brblack
set -l red C34043 red
set -l orange FF9E64 brred
set -l yellow C0A36E yellow
set -l green 76946A green
set -l purple 957FB8 magenta
set -l cyan 7AA89F cyan
set -l pink D27E99 brmagenta

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
