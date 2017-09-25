# Setup fzf
# ---------
if [[ ! "$PATH" == */home/grant/.fzf/bin* ]]; then
  export PATH="$PATH:/home/grant/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/grant/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/grant/.fzf/shell/key-bindings.zsh"

fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

