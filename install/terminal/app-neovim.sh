# Takes forever to build, so we included a binary
echo "Installing Neovim system-wide..."

# Define the tarball location
TARBALL="$HOME/.local/share/omakub/tars/neovim-pi-zero.tar.gz"

if [[ -f "$TARBALL" ]]; then
    echo "Extracting Neovim..."
    # Extract to a temporary directory
    sudo tar -xzf "$HOME/.local/share/omakub/tars/neovim-pi-zero.tar.gz" -C /
    sudo chmod +x /usr/share/bin/nvim

    # Clean up the temporary directory

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

    echo "Lazy will probably die on an older pi if you don't set concurrency to a real low number and throttle git"
    echo "edit ./config/nvim/lua/config/lazy.lua"
    LAZY_FILE=~/.config/nvim/lua/config/lazy.lua

    # Add the checker and git configurations
    awk '
    /^return {/ {
        print $0
        print "  checker = {"
        print "    concurrency = 1,"
        print "  },"
        print "  git = {"
        print "    throttle = {"
        print "      enabled = true,"
        print "      rate = 2,"
        print "      duration = 5 * 1000,"
        print "    },"
        print "  },"
        next
    }
    { print }
    ' "$LAZY_FILE" > "$LAZY_FILE.tmp" && mv "$LAZY_FILE.tmp" "$LAZY_FILE"
    
    echo "Configuration updated successfully!"
fi

# Replace desktop launcher with one running inside Alacritty
if [[ -d ~/.local/share/applications ]]; then
    echo "Configuring desktop launcher..."
    sudo rm -rf /usr/share/applications/nvim.desktop
    source ~/.local/share/omakub/applications/Neovim.sh
fi
