# README

dotfiles for quickly setting up my development environment.

UI used across all applications
 - Theme: Catppuccin
 - Font: JetBrainsMono Nerd Font


Configuration added for
- Alacritty
- Oh My Posh
	- Block added for transient prompt
- Starship
	- With transient prompt
- Tmux


### Creating a VM
Create a multipass VM. Cloud init yaml has configuration to install fish shell
```console
multipass launch docker -v \
  --name primary \
  --cpus 4 \
  --memory 8G \
  --disk 50G \
  --cloud-init https://raw.githubusercontent.com/ti-colinthomas/dotfiles/main/init.yaml
```
After creation of VM use the below command to change the default shell to fish
```console
chsh -s $(which fish)
```


### Installation
This installation assumes that you already have fish shell installed
```console
git clone https://github.com/ti-colinthomas/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles && chmod u+x install.sh
cd $HOME/.dotfiles && ./install.sh
```
