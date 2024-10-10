
if status is-interactive
    # ------------------------
    # GLOBALS
    # ------------------------
    set -g fish_greeting
    
    set -x EDITOR "emacs"

    # ------------------------
    # PATHS
    # ------------------------
    set -x PATH $HOME/bin /usr/local/bin $PATH

    # Add .local/bin
    set -x PATH $HOME/.local/bin $PATH

    # Zig
    set -x PATH $HOME/.zig $PATH

    # GOLANG
    set -x PATH /usr/bin/go/bin $PATH
    set -x PATH $HOME/go/bin $PATH
    set -x PATH $HOME/go/bin/gopls $PATH

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
    alias wiki "cd ~/Mega/vim_wiki; vim index.md"
end

# ------------------------
# THEME START
# ------------------------
# TokyoNight Color Palette
set -l foreground c0caf5
set -l selection 283457
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

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
set -g fish_pager_color_selected_background --background=$selection
# ------------------------
# THEME END
# ------------------------
