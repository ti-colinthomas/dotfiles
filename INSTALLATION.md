# Cloning dotfiles and stowing it
```shell
git clone https://github.com/ti-colinthomas/dotfiles.git $HOME/.dotfiles
sudo apt -y install stow
cd $HOME/.dotfiles
stow .
cd $HOME
```

# Setup password
# This is required for some of the items below like starship.rs
```
sudo passwd ubuntu
```

# Install starship
```shell
curl -sS https://starship.rs/install.sh | sh
echo -e "\n" >> $HOME/.profile
echo "# Initializing starship" >> $HOME/.profile
echo 'eval "$(starship init bash)"' >> $HOME/.profile
source $HOME/.profile
```

# Install Zoxide
```shell
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
echo "Adding ~/.local/bin to \$PATH"
PATH=$PATH:$HOME/.local/bin
echo -e "\n" >> $HOME/.profile
echo "# Initializing Zoxide" >> $HOME/.profile
echo 'eval "$(zoxide init bash --cmd cd)"' >> $HOME/.profile
source $HOME/.profile
```

# Install fzf
```shell
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.sources/fzf
~/.sources/fzf/install
echo '[ -f ~/.fzf.bash ] && source ~/.fzf.bash' >> $HOME/.profile

# If completions were added to .bashrc the below line will delete it
sed -i '$ d' $HOME/.bashrc
```

# Install Tmux
```shell
sudo apt -y install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
# TODO: After installing the catppuccin theme change the round statusbar to rect
# file: ~/.config/tmux/plugins/tmux/catppuccin.tmux

# Install Neovim
```shell
sudo snap install nvim --classic
```

# Neovim dependencies
# For Telescope
```shell
sudo apt-get -y install fd-find
ln -s $(which fdfind) $HOME/.local/bin/fd
```
