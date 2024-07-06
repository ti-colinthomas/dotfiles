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
```

Optionally you can also change the directory that is shared. By default multipass shares the entire home folder of the host.
```
echo "umount default dir"
multipass umount primary:primary
rm -rf ~/multipass
multipass exec primary -- rm -rfv /home/ubuntu/primary

echo "mount ~/code"
multipass mount ~/code primary:~/code
```
