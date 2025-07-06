# ZSH Configuration
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"
fi

# Alias
alias ls="eza"
alias ll="eza --git --git-repos -alh"
alias tree="eza --tree"

# Source zshenv
source ~/.zshenv
