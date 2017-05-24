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

