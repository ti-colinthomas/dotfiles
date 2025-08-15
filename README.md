# Dotfiles Setup

Sets up my development environment on MacOS and multipass VMs.
Use the bare minimum of plugins for applications like vim and tmux.

## Features

This setup script:

- Installs [Homebrew](https://brew.sh/) if it's not already installed
- Uses [GNU Stow](https://www.gnu.org/software/stow/) to manage dotfiles
- Installs and configures:
  - `bat` with [Catppuccin Mocha](https://github.com/catppuccin/bat) theme
  - `delta` with [Catppuccin Mocha](https://github.com/catppuccin/delta) theme
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

- Git
- Zsh
- Multipass (If you are going to create a vm)

## macOS

Clone this repository into your home directory (or symlink it as needed):

```bash
git clone https://github.com/ti-colinthomas/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x setup.sh
./setup.sh
```

## Multipass

Create a multipass vm and configure it for development. Edit the multipass file as necessary, it has some configuration variables that need to be set.

```bash
git clone https://github.com/ti-colinthomas/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x multipass.sh
./multipass.sh
```
