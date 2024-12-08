#!/bin/bash

# Display system information in the terminal
echo "Extracting fastfetch..."

# Ensure destination directory exists
mkdir -p ~/.local/share/omakub/bin/

# Extract the tar.gz file
if tar -xzf ~/.local/share/omakub/tars/fastfetch.tar.gz -C ~/.local/share/omakub/bin/; then
  echo "Extraction successful."
else
  echo "Error: Extraction failed. Check the tar.gz file and destination directory."
  exit 1
fi

# Make the binary executable
chmod +x ~/.local/share/omakub/bin/fastfetch

# Only attempt to set configuration if not already set
if [ ! -f "$HOME/.config/fastfetch/config.jsonc" ]; then
  # Use Omakub fastfetch config
  mkdir -p ~/.config/fastfetch
  cp ~/.local/share/omakub/configs/fastfetch.jsonc ~/.config/fastfetch/config.jsonc
  echo "Configuration file set up at ~/.config/fastfetch/config.jsonc"
else
  echo "Configuration already exists. Skipping setup."
fi
