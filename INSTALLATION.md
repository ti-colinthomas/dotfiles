### Install fish and setup default shell
```shell
sudo apt-add-repository ppa:fish-shell/release-3  
sudo apt update
sudo apt -y install fish
sudo passwd ubuntu
chsh -s $(which fish)
fish && exit
```

### Install starship
```shell
curl -sS https://starship.rs/install.sh | sh
echo -e "\n" >> $HOME/.config/fish/config.fish
echo "# Init Starship" >> $HOME/.config/fish/config.fish
echo "starship init fish | source" >> $HOME/.config/fish/config.fish
echo "enable_transience" >> $HOME/.config/fish/config.fish
set -Ux STARSHIP_CONFIG $HOME/.config/starship.toml
fish && exit
```

### Clone dotfiles and stow them
```shell
git clone https://github.com/ti-colinthomas/dotfiles.git $HOME/.dotfiles
sudo apt -y install stow
cd $HOME/.dotfiles
stow .
cd $HOME
```

### Install Zoxide
```shell
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
echo -e "\n" >> $HOME/.config/fish/config.fish
echo "# Init Zoxide" >> $HOME/.config/fish/config.fish
echo "zoxide init fish --cmd cd | source" >> $HOME/.config/fish/config.fish
echo "Adding $HOME/.local/bin to \$PATH"
fish_add_path $HOME/.local/bin
fish && exit
```

### Install fzf
```shell
mkdir $HOME/.sources
git clone https://github.com/junegunn/fzf.git $HOME/.sources/fzf
$HOME/.sources/fzf/install
rm $HOME/.fzf.bash
fish && exit
```

### Install Fisher
```shell
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

### Install Tmux
```shell
sudo apt -y install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Neovim
```shell
sudo snap install --beta nvim --classic
```
