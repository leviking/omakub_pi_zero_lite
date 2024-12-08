# Display system information in the terminal
sudo sh -c 'echo "deb http://ppa.launchpad.net/zhangsongcui3371/fastfetch/ubuntu focal main" > /etc/apt/sources.list.d/fastfetch.list'
curl -fsSL https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xF566E19D8027B3EB1A3FC47E42E5C84D | gpg --dearmor | sudo tee /etc/apt/keyrings/fastfetch.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/fastfetch.gpg] https://ppa.launchpadcontent.net/zhangsongcui3371/fastfetch/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/fastfetch.list
sudo apt update -y
sudo apt install -y fastfetch

# Only attempt to set configuration if fastfetch is not already set
if [ ! -f "$HOME/.config/fastfetch/config.jsonc" ]; then
  # Use Omakub fastfetch config
  mkdir -p ~/.config/fastfetch
  cp ~/.local/share/omakub/configs/fastfetch.jsonc ~/.config/fastfetch/config.jsonc
fi
