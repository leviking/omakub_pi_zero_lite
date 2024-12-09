echo "installing neovim"

# Takes forever to build so we included a binary
if [[ -f ~/.local/share/omakub/tars/nvim.tar.gz ]]; then
    echo "Extracting Neovim..."
    if tar -xzf ~/.local/share/omakub/tars/nvim.tar.gz -C ~/.local/share/omakub/bin/; then
        echo "Adding Neovim to PATH..."
        chmod +x ~/.local/share/omakub/bin/nvim/bin/nvim
        export PATH="$HOME/.local/share/omakub/bin/nvim/bin:$PATH"
        echo 'export PATH="$HOME/.local/share/omakub/bin/nvim/bin:$PATH"' >> ~/.bashrc
        echo "Neovim extracted and configured successfully."
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
	# Use LazyVim
	git clone https://github.com/LazyVim/starter ~/.config/nvim
	# Remove the .git folder, so you can add it to your own repo later
	rm -rf ~/.config/nvim/.git

	# Make everything match the terminal transparency
	mkdir -p ~/.config/nvim/plugin/after
	cp ~/.local/share/omakub/configs/neovim/transparency.lua ~/.config/nvim/plugin/after/

	# Default to Tokyo Night theme
	cp ~/.local/share/omakub/themes/tokyo-night/neovim.lua ~/.config/nvim/lua/plugins/theme.lua

	# Enable default extras
	cp ~/.local/share/omakub/configs/neovim/lazyvim.json ~/.config/nvim/lazyvim.json
fi

# Replace desktop launcher with one running inside Alacritty
if [[ -d ~/.local/share/applications ]]; then
	sudo rm -rf /usr/share/applications/nvim.desktop
	source ~/.local/share/omakub/applications/Neovim.sh
fi
