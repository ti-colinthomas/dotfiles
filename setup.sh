#!/bin/bash

# Stow
# Creates the directory structure
if ! brew list --formula | grep -q "^stow$"; then
	brew install stow
fi
stow .

# Required environment variables
source $HOME/.zshenv

# Local variables
CONFIG_DIR="./.config"

# Exit on error
set -e

# Function to check if Homebrew is installed
is_homebrew_installed() {
  command -v brew >/dev/null 2>&1
}

# Homebrew
if is_homebrew_installed; then
	echo "Homebrew is already installed. Skipping installation."
else
	echo "Homebrew not found. Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo >> $HOME/.zprofile
	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if ! brew list --formula | grep -q "^wget$"; then
	brew install wget
fi

# Fonts
echo 'Checking fonts'
if ! brew list --cask | grep -q "^font-ubuntu-sans-nerd-font"; then
	brew install font-ubuntu-sans-nerd-font
fi
if ! brew list --cask | grep -q "^font-sauce-code-pro-nerd-font"; then
	brew install font-sauce-code-pro-nerd-font
fi
if ! brew list --cask | grep -q "^font-jetbrains-mono-nerd-font$"; then
	brew install font-jetbrains-mono-nerd-font
fi

echo 'Installing and configuring tools'
echo 'bat'
# bat
if ! brew list --formula | grep -q "^bat$"; then
	# Install bat
	echo 'Installing bat'
	brew install bat
	# Setup bat
	mkdir -p "$(bat --config-dir)/themes"
	wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
	bat cache --build
fi

echo 'delta'
# delta
if ! brew list --formula | grep -q "^git-delta$"; then
	brew install git-delta
	mkdir -p "$CONFIG_DIR/delta/themes"
	wget -P "$CONFIG_DIR/delta/themes" https://raw.githubusercontent.com/catppuccin/delta/refs/heads/main/catppuccin.gitconfig 
fi

echo 'fzf'
# fzf
if ! brew list --formula | grep -q "^fzf$"; then
	brew install fzf
	chmod +x ~/.config/fzf/preview.sh
fi

echo 'fd'
# fd
if ! brew list --formula | grep -q "^fd$"; then
	brew install fd
fi

echo 'oh-my-posh'
# OMP
if ! brew list --formula | grep -q "^oh-my-posh$"; then
	brew install jandedobbeleer/oh-my-posh/oh-my-posh
fi

echo 'eza'
# Eza
if ! brew list --formula | grep -q "^eza$"; then
	brew install eza
	# Configure eza
	mkdir -p "$CONFIG_DIR/eza"
	wget -O "$CONFIG_DIR/eza/theme.yml" https://raw.githubusercontent.com/eza-community/eza-themes/refs/heads/main/themes/catppuccin.yml
fi

echo 'jq'
# jq
if ! brew list --formula | grep -q "^jq$"; then
	brew install jq
fi

echo 'zoxide'
# Zoxide
if ! brew list --formula | grep -q "^zoxide$"; then
	brew install zoxide
fi

echo 'nvm'
# Nvm
if ! brew list --formula | grep -q "^nvm$"; then
	brew install nvm
fi

echo 'Aerospace'
# Aerospace
if ! brew list --cask | grep -q "^aerospace$"; then
	brew install --cask nikitabobko/tap/aerospace
	
	# Disabling this for now
	# Mutliple monitors cause issues that I just don't want to deal with right now
	#
	# chmod +x ./config/aerospace/scripts/disable_displays_have_seperate_spaces.sh
	# /bin/bash -c ./config/aerospace/scripts/disable_displays_have_seperate_spaces.sh
fi

echo 'Tmux'
# Tmux
if ! brew list --formula | grep -q "^tmux$"; then
	brew install tmux
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	mkdir "$CONFIG_DIR/tmux/themes"
	git clone -b v2.1.3 https://github.com/catppuccin/tmux.git $CONFIG_DIR/tmux/themes
fi

echo 'neovim'
# Neovim
if ! brew list --formula | grep -q "^neovim$"; then
	brew install neovim
fi
