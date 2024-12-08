# Display system information in the terminal
echo "extracting fastfetch"
tar -xzf ~/.local/share/omakub/tars/fastfetch.tar.gz ~/.local/share/omakub/bin/ 

# Only attempt to set configuration if fastfetch is not already set
if [ ! -f "$HOME/.config/fastfetch/config.jsonc" ]; then
  # Use Omakub fastfetch config
  mkdir -p ~/.config/fastfetch
  cp ~/.local/share/omakub/configs/fastfetch.jsonc ~/.config/fastfetch/config.jsonc
fi
