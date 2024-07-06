#!/bin/bash
# Stow
sudo apt install stow -y
cd $HOME/.dotfiles
stow .
cd $HOME

# Starship
curl -sS https://starship.rs/install.sh | sh
echo -e "\n" >> $HOME/.config/fish/config.fish
echo "# Init Starship" >> $HOME/.config/fish/config.fish
echo "starship init fish | source" >> $HOME/.config/fish/config.fish
echo "enable_transience" >> $HOME/.config/fish/config.fish
set -Ux STARSHIP_CONFIG $HOME/.config/starship.toml

# Zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fish_add_path $HOME/.local/bin
echo -e "\n" >> $HOME/.config/fish/config.fish
echo "# Init Zoxide" >> $HOME/.config/fish/config.fish
echo "zoxide init fish --cmd cd| source" >> $HOME/.config/fish/config.fish

# fzf
mkdir $HOME/.sources
git clone https://github.com/junegunn/fzf.git $HOME/.sources/fzf
$HOME/.sources/fzf/install
rm $HOME/.fzf.bash

# Fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# Tmux
sudo apt install tmux -y
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Neovim
sudo snap install --beta nvim --classic