# Dotfiles Setup

A macOS-friendly bootstrap script for setting up a modern terminal environment using Homebrew, GNU Stow, and various developer productivity tools.

## Features

This setup script:

- Installs [Homebrew](https://brew.sh/) if it's not already installed
- Uses [GNU Stow](https://www.gnu.org/software/stow/) to manage dotfiles
- Installs and configures:
  - `bat` with [Catppuccin Mocha](https://github.com/catppuccin/bat) theme
  - `delta` with [Catppuccin Delta](https://github.com/catppuccin/delta) theme
  - `fzf` with preview script support
  - `fd` for fast file finding
  - `oh-my-posh` for shell theming
  - `eza` (modern replacement for `ls`) with Catppuccin theme
  - `zoxide` for smarter `cd` navigation
  - `aerospace` for a window manager
  - `tmux` for terminal emulation
  - `neovim` for an IDE
- Installs Nerd Fonts:
  - Ubuntu Sans
  - Sauce Code Pro
  - JetBrains Mono

## Prerequisites

- macOS
- Git
- Zsh
- Multipass (If you are going to create a vm)

## Usage

Clone this repository into your home directory (or symlink it as needed):

```bash
git clone https://github.com/ti-colinthomas/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x setup.sh
./setup.sh
```

## Multipass

Create a multipass vm and configure it for development. Edit the multipass file as necessary, it has some configuration items that need to be set.

```bash
git clone https://github.com/ti-colinthomas/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x multipass.sh
./multipass.sh
```
