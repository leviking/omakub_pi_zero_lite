
echo "Installing Neovim..."

# Takes forever to build, so we included a binary
if [[ -f ~/.local/share/omakub/tars/nvim.tar.gz ]]; then
    echo "Extracting Neovim..."
    # Extract the tarball
    if tar -xzf ~/.local/share/omakub/tars/nvim.tar.gz -C ~/.local/share/omakub/; then
        echo "Adding Neovim binary to PATH..."
        chmod +x ~/.local/share/omakub/bin/neovim/bin/nvim

        echo "Configuring Neovim runtime..."
        # Ensure runtimepath is correctly set
        if [ ! -d "$HOME/.local/share/nvim" ]; then
            mkdir -p ~/.local/share/nvim
        fi
        cp -r ~/.local/share/omakub/share/nvim/* ~/.local/share/nvim/
        echo "Neovim runtime configured successfully."

        echo "Neovim installed successfully."
    else
        echo "Error: Failed to extract Neovim. Please check the archive."
        exit 1
    fi
else
    echo "Error: nvim.tar.gz not found in ~/.local/share/omakub/tars/"
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
