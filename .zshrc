# ZSH Configuration
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"
fi

# Fix for ERROR: missing or unsuitable terminal: xterm-ghostty
if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    export TERM=xterm-256color
fi

# Alias
alias ls="eza"
alias ll="eza --git --git-repos -alh"
alias tree="eza --tree"
if command -v batcat &> /dev/null; then
    alias bat='batcat'
fi
if command -v fdfind &> /dev/null; then
    alias fd='fdfind'
fi
# Tmux
# Function to attach to a tmux session or create a new one
# Usage:
#   tma                 # Attaches to the last active session, or creates a new one named 'default'
#   tma my_session      # Attaches to 'my_session' if it exists, otherwise creates it

tn() {
  local session_name="$1"

  if [ -z "$session_name" ]; then
    # If no session name is provided, try to attach to the last active session
    # If no sessions exist, it will create a new one with a default name (tmux will usually use 0 or default)
    tmux attach || tmux new
  else
    # Check if the provided session name exists
    tmux has-session -t "$session_name" 2>/dev/null

    if [ $? -eq 0 ]; then
      # Session exists, attach to it
      tmux attach -t "$session_name"
    else
      # Session does not exist, create a new one with the provided name
      tmux new -s "$session_name"
    fi
  fi
}
alias ta="tn"
alias tl="tmux list-sessions"

# fzf
# Setup key bindings
eval "$(fzf --zsh)"

# zoxide
eval "$(zoxide init zsh --cmd cd)"

# Source zshenv
source ~/.zshenv

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
