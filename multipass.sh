#!/bin/bash
# --- Begin configuration --
# --- Configuration Variables ---
INSTANCE_NAME="primary"
MEM_SIZE="4G"
DISK_SIZE="20G"
CPU_COUNT="2"

# Separate arrays for host and guest paths
HOST_PATHS=(
    "/Users/colin/code"
    "/Users/colin/dotfiles"
)
GUEST_PATHS=(
    "/home/ubuntu/code"
    "/home/ubuntu/dotfiles"
)
# --- End configuration --
# --- For a basic setup, you don't need to change anything beyond this ---

# List of additional APT packages to install
APT_PACKAGES=(
    "unzip"
    "stow"
    "bat"
    "git-delta"
    "fd-find"
    "ripgrep"
    "eza"
    "tmux"
    "build-essential"
    "cmake"
)

check_error() {
    if [ $? -ne 0 ]; then
        echo -e "\033[0;31mERROR: $1\033[0m" >&2
        multipass delete "$INSTANCE_NAME" &>/dev/null
        multipass purge
        exit 1
    fi
}

# Define colors
GREEN='\033[0;32m'  # Green color for info
RED='\033[0;31m'    # Red color for error
YELLOW='\033[1;33m' # Yellow color for debug
NC='\033[0m'        # No Color

# Logging function
log() {
    local loglevel="$1"
    shift
    local message="$@"

    case "$loglevel" in
        info)
            echo -e "${GREEN}[INFO] ${message}${NC}"
            ;;
	debug)
            echo -e "${YELLOW}[DEBUG] ${message}${NC}"
            ;;
        error)
            echo -e "${RED}[ERROR] ${message}${NC}"
            ;;
        *)
            echo "[UNKNOWN] $message"
            ;;
    esac
}


log info "Checking for existing Multipass instance: $INSTANCE_NAME "
if multipass info "$INSTANCE_NAME" &>/dev/null; then
    log info "Instance '$INSTANCE_NAME' already exists. Deleting it..."
    multipass delete "$INSTANCE_NAME"
    multipass purge
    log info "Instance '$INSTANCE_NAME' deleted."
fi

# Ensure all host share paths exist
for path in "${HOST_PATHS[@]}"; do
    if [ ! -d "$path" ]; then
        log info "Creating host share directory: $path"
        mkdir -p "$path"
        check_error "Failed to create host share directory '$path'."
    fi
done

# Launch VM
log info "Launching Multipass instance: $INSTANCE_NAME with $MEM_SIZE RAM, $DISK_SIZE disk, $CPU_COUNT CPUs "
multipass launch --name "$INSTANCE_NAME" --memory "$MEM_SIZE" --disk "$DISK_SIZE" --cpus "$CPU_COUNT"
check_error "Failed to launch Multipass instance '$INSTANCE_NAME'."

log info "Unmounting default shared location "
multipass umount "$INSTANCE_NAME"

# Mount folders
log info "Mounting custom folders "
for i in "${!HOST_PATHS[@]}"; do
    host_path="${HOST_PATHS[$i]}"
    guest_path="${GUEST_PATHS[$i]}"
    echo "  Mounting $host_path to $guest_path"
    multipass exec "$INSTANCE_NAME" -- sudo mkdir -p "$guest_path"
    check_error "Failed to create guest directory '$guest_path'"
    multipass mount "$host_path" "$INSTANCE_NAME":"$guest_path"
    check_error "Failed to mount '$host_path' to '$guest_path'"
done

log info "Updating and Upgrading packages "
multipass exec "$INSTANCE_NAME" -- sudo apt update -y
check_error "Failed to update packages."
# multipass exec "$INSTANCE_NAME" -- sudo apt upgrade -y
# check_error "Failed to upgrade packages."

log info "Installing Zsh "
multipass exec "$INSTANCE_NAME" -- sudo apt install -y zsh zsh-doc zsh-common
check_error "Failed to install Zsh."

multipass exec "$INSTANCE_NAME" -- bash -c '
    CURRENT_SHELL=$(getent passwd ubuntu | cut -d: -f7)
    if [ "$CURRENT_SHELL" != "$(which zsh)" ]; then
        sudo chsh -s "$(which zsh)" ubuntu
        echo "Zsh set as default shell."
    else
        echo "Zsh is already the default shell."
    fi
'
check_error "Failed to set Zsh as default shell."

log info "Adding repository for eza to API Sources"
multipass exec "$INSTANCE_NAME" -- bash -c '
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
'
check_error "Failed to add repository for eza"

if [ ${#APT_PACKAGES[@]} -gt 0 ]; then
    log info "Installing additional APT packages "
    for pkg in "${APT_PACKAGES[@]}"; do
        log info "  Installing $pkg..."
        multipass exec "$INSTANCE_NAME" -- sudo apt install -y "$pkg"
        check_error "Failed to install package '$pkg'."
    done
else
    log info "No additional APT packages specified."
fi

log info "Installing fzf "
multipass exec "$INSTANCE_NAME" -- bash -c '
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all --no-bash 
    rm ~/.zshrc
'
check_error "Failed to install fzf"

log info "Installing Zoxide "
multipass exec "$INSTANCE_NAME" -- bash -c '
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
'
check_error "Failed to install zoxide"

log info "Installing oh-my-posh "
multipass exec "$INSTANCE_NAME" -- bash -c '
    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin

'
check_error "Failed to install oh-my-posh"

log info "Writing .zprofile "
multipass exec "$INSTANCE_NAME" -- bash -c '
    echo "# Custom .zprofile settings" >> ~/.zprofile
    echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> ~/.zprofile
    echo "export EDITOR=\"vim\"" >> ~/.zprofile
    echo "# Setup fzf" >> ~/.zprofile
    echo "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" >> ~/.zprofile
    echo "echo \"Welcome to your Multipass Dev Environment!\"" >> ~/.zprofile
'
check_error "Failed to write .zprofile."

log info "Finalizing Setup "

log debug "Stowing config files"
multipass exec "$INSTANCE_NAME" -- bash -c '
    echo "Stowing from : $(pwd)"
    stow .
'

log info "Applying catppuccin theme for bat"
multipass exec "$INSTANCE_NAME" -- bash -c '
    export BAT_CONFIG_PATH="$HOME/.config/bat/bat.conf"
    mkdir -p "$(batcat --config-dir)/themes"
    wget -P "$(batcat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
    batcat cache --build
'
check_error "Failed to apply theme for bat"

log info "Applying catppuccin theme for delta"
multipass exec "$INSTANCE_NAME" -- bash -c '
    mkdir -p "$HOME/.config/delta/themes"
    wget -P "$HOME/.config/delta/themes" https://raw.githubusercontent.com/catppuccin/delta/refs/heads/main/catppuccin.gitconfig
'
check_error "Failed to apply theme for delta"

log info "Applying catppuccin theme for eza"
multipass exec "$INSTANCE_NAME" -- bash -c '
    mkdir -p "$HOME/.config/eza"
    wget -O "$HOME/.config/eza/theme.yml" https://raw.githubusercontent.com/eza-community/eza-themes/refs/heads/main/themes/catppuccin.yml

'
check_error "Failed to apply theme for eza"

log info "Setting up the preview action for fzf"
multipass exec "$INSTANCE_NAME" -- bash -c '
    chmod +x ~/.config/fzf/preview.sh
'
check_error "Failed to setup the preview action for fzf"

log info "Setting up tpm for tmux"
multipass exec "$INSTANCE_NAME" -- bash -c '
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    if [ -d "$HOME/.config/tmux/themes" ]; then
	echo "Tmux theme already exists"
    else
	echo "Create themes directory for tmux"
	mkdir -p "$HOME/.config/tmux/themes"
	git clone -b v2.1.3 https://github.com/catppuccin/tmux.git $HOME/.config/tmux/themes
    fi
'
check_error "Failed to setup tpm"

log info "APT sources do not contain latest release of neovim"
log info "Script will now attempt to build neovim from source"
multipass exec "$INSTANCE_NAME" -- bash -c '
    read -p "Press enter to continue."
'
log info "Building neovim from source"
multipass exec "$INSTANCE_NAME" -- bash -c '
    git clone https://github.com/neovim/neovim $HOME/build/neovim
    cd $HOME/build/neovim
    git checkout stable
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    cd build && cpack -G DEB && sudo dpkg -i nvim-linux-$(dpkg --print-architecture).deb
    cd $HOME && rm -rf $HOME/build
'
check_error "Failed to install neovim"

log info "Setup complete for $INSTANCE_NAME!"
log info "You can connect using: multipass shell $INSTANCE_NAME"
log info "Mounted directories:"
for i in "${!HOST_PATHS[@]}"; do
    echo "  ${HOST_PATHS[$i]} -> ${GUEST_PATHS[$i]}"
done

