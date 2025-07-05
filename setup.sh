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
if ! brew list --formula | grep -q "^font-ubuntu-sans"; then
	brew install font-ubuntu-sans-nerd-font
fi
if ! brew list --formula | grep -q "^font-sauce-code"; then
	brew install font-sauce-code-pro-nerd-font
fi
if ! brew list --formula | grep -q "^font-jetbrains$"; then
	brew install font-jetbrains-mono-nerd-font
fi

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

# delta
if ! brew list --formula | grep -q "^git-delta$"; then
	brew install git-delta
	mkdir -p "$CONFIG_DIR/delta/themes"
	wget -P "$CONFIG_DIR/delta/themes" https://raw.githubusercontent.com/catppuccin/delta/refs/heads/main/catppuccin.gitconfig 
fi

# fzf
if ! brew list --formula | grep -q "^fzf$"; then
	brew install fzf
fi

# OMP
if ! brew list --formula | grep -q "^oh-my-posh$"; then
	brew install jandedobbeleer/oh-my-posh/oh-my-posh
fi

# Eza
if ! brew list --formula | grep -q "^eza$"; then
	brew install eza
	# Configure eza
	mkdir -p "$CONFIG_DIR/eza"
	wget -O "$CONFIG_DIR/eza/theme.yml" https://raw.githubusercontent.com/eza-community/eza-themes/refs/heads/main/themes/catppuccin.yml
fi

