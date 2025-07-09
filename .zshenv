export BAT_CONFIG_PATH="$HOME/.config/bat/bat.conf"
export BAT_THEME="Catppuccin Mocha"

export EZA_CONFIG_DIR=$HOME/.config/eza

export FZF_COMPLETION_TRIGGER="--"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix"

# Disabling previews till I find a way to only enable this with the completion trigger
# export FZF_DEFAULT_OPTS="--border top --preview '~/.config/fzf/preview.sh {}' --preview-window=right:60%"

_fzf_compgen_path() {
	fd --hidden . "$1"
}

_fzf_compgen_dir() {
	fd --type=d --hidden . "$1"
}

