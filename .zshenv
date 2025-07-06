export BAT_CONFIG_PATH="$HOME/.config/bat/bat.conf"
export BAT_THEME="Catppuccin Mocha"

export EZA_CONFIG_DIR=$HOME/.config/eza

export FZF_COMPLETION_TRIGGER="--"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix"
export FZF_CTRL_T_COMMAND="$FZF_CTRL_T_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix"

_fzf_compgen_path() {
	fd --hidden . "$1"
}

_fzf_compgen_dir() {
	fd --type=d --hidden . "$1"
}
