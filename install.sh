#!/bin/bash
# Stow
sudo apt install stow -y
cd $HOME/.dotfiles
stow .
cd $HOME

# Setup password
sudo passwd ubuntu

# Starship
curl -sS https://starship.rs/install.sh | sh
echo -e "\n" >> $HOME/.profile
echo "# Initializing starship" >> $HOME/.profile
echo 'eval "$(starship init bash)"' >> $HOME/.profile
source $HOME/.profile

# Zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
echo "Adding ~/.local/bin to \$PATH"
PATH=$PATH:$HOME/.local/bin
echo -e "\n" >> $HOME/.profile
echo "# Initializing Zoxide" >> $HOME/.profile
echo 'eval "$(zoxide init bash --cmd cd)"' >> $HOME/.profile
source $HOME/.profile

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.sources/fzf
~/.sources/fzf/install
echo '[ -f ~/.fzf.bash ] && source ~/.fzf.bash' >> $HOME/.profile

# If completions were added to .bashrc the below line will delete it
sed -i '$ d' $HOME/.bashrc

# Tmux
# sudo apt install tmux -y
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Neovim
sudo snap install nvim --classic
