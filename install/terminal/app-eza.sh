
#!/bin/bash

echo "Installing eza for ARM..."

# Step 1: Fetch the latest version from GitHub API
EZA_VERSION=$(curl -s "https://api.github.com/repos/eza-community/eza/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

if [[ -z "$EZA_VERSION" ]]; then
  echo "Error: Unable to fetch the latest version of eza."
  exit 1
fi

# Step 2: Construct the download URL
DOWNLOAD_URL="https://github.com/eza-community/eza/releases/download/v${EZA_VERSION}/eza_arm-unknown-linux-gnueabihf.tar.gz"

# Step 3: Change to a temporary directory
cd /tmp || exit 1

# Step 4: Download the tar.gz file
echo "Downloading eza version $EZA_VERSION from $DOWNLOAD_URL..."
curl -sLo eza.tar.gz "$DOWNLOAD_URL"

# Step 5: Verify the download
if [[ ! -f eza.tar.gz ]]; then
  echo "Error: Failed to download eza from $DOWNLOAD_URL."
  exit 1
fi

# Step 6: Extract the binary
echo "Extracting eza..."
tar -xf eza.tar.gz

# Step 7: Install the binary to /usr/local/bin
echo "Installing eza to /usr/local/bin..."
sudo install eza /usr/local/bin/

# Step 8: Clean up temporary files
rm -f eza.tar.gz eza

# Step 9: Verify installation
if command -v eza &>/dev/null; then
  echo "eza successfully installed!"
  eza --version
else
  echo "Error: eza installation failed."
  exit 1
fi
