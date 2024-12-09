# Takes forever to build, so we included a binary
echo "Installing Neovim system-wide..."

# Define the tarball location
TARBALL="$HOME/.local/share/omakub/tars/nvim.tar.gz"

if [[ -f "$TARBALL" ]]; then
    echo "Extracting Neovim..."
    # Extract to a temporary directory
    TEMP_DIR=$(mktemp -d)
    tar -xzf "$TARBALL" -C "$TEMP_DIR"

    # Move the binary and runtime files to the appropriate system-wide locations
    echo "Moving Neovim binary to /usr/local/bin..."
    sudo mv "$TEMP_DIR/bin/nvim" /usr/local/bin/

    echo "Moving Neovim runtime files to /usr/local/share..."
    sudo mkdir -p /usr/local/share/nvim
    sudo mv "$TEMP_DIR/share/nvim/"* /usr/local/share/nvim/

    # Clean up the temporary directory
    rm -rf "$TEMP_DIR"

    # Verify installation
    if command -v nvim &>/dev/null; then
        echo "Neovim installed successfully!"
        nvim --version
    else
        echo "Error: Neovim installation failed."
        exit 1
    fi
else
    echo "Error: Neovim tarball not found at $TARBALL."
    exit 1
fi


# Only attempt to set configuration if Neovim has never been run
if [ ! -d "$HOME/.config/nvim" ]; then
    echo "Setting up Neovim configuration..."
    # Use LazyVim
    git clone https://github.com/LazyVim/starter ~/.config/nvim
    # Remove the .git folder so you can add it to your own repo later
    rm -rf ~/.config/nvim/.git

    # Make everything match the terminal transparency
    mkdir -p ~/.config/nvim/plugin/after
    cp ~/.local/share/omakub/configs/neovim/transparency.lua ~/.config/nvim/plugin/after/

    # Default to Tokyo Night theme
    cp ~/.local/share/omakub/themes/tokyo-night/neovim.lua ~/.config/nvim/lua/plugins/theme.lua

    # Enable default extras
    cp ~/.local/share/omakub/configs/neovim/lazyvim.json ~/.config/nvim/lazyvim.json
    echo "Neovim configuration set up successfully."
fi

# Replace desktop launcher with one running inside Alacritty
if [[ -d ~/.local/share/applications ]]; then
    echo "Configuring desktop launcher..."
    sudo rm -rf /usr/share/applications/nvim.desktop
    source ~/.local/share/omakub/applications/Neovim.sh
fi
