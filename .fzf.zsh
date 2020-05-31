# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mping/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/mping/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/mping/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/mping/.fzf/shell/key-bindings.zsh"
