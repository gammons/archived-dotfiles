if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

source ~/.aliases
source ~/.asdf/asdf.fish

source ~/.fzf/shell/key-bindings.fish

set SHELL /usr/bin/fish

if not set -q TMUX
    set DATE (date +%s)
    set -g TMUX tmux new-session -d -s $DATE
    eval $TMUX
    tmux attach-session -d -t $DATE
end

starship init fish | source
