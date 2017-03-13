# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ubuntu/.fzf/bin* ]]; then
  export PATH="$PATH:/home/ubuntu/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ubuntu/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/ubuntu/.fzf/shell/key-bindings.zsh"
