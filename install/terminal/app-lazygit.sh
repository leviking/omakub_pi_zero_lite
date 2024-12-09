#!/bin/bash

echo "Installing lazygit for ARMv6..."

# Step 1: Fetch the latest version number from the GitHub API
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

if [[ -z "$LAZYGIT_VERSION" ]]; then
  echo "Error: Unable to fetch the latest version of lazygit."
  exit 1
fi

# Step 2: Construct the correct download URL for ARMv6
DOWNLOAD_URL="https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_armv6.tar.gz"

# Step 3: Download the tar.gz file
echo "Downloading lazygit version $LAZYGIT_VERSION from $DOWNLOAD_URL..."
curl -sLo lazygit.tar.gz "$DOWNLOAD_URL"

# Step 4: Verify the download
if [[ ! -f lazygit.tar.gz ]]; then
  echo "Error: Failed to download lazygit from $DOWNLOAD_URL."
  exit 1
fi

# Step 5: Extract the binary
echo "Extracting lazygit..."
tar -xf lazygit.tar.gz lazygit

# Step 6: Install the binary to /usr/local/bin
echo "Installing lazygit to /usr/local/bin..."
sudo install lazygit /usr/local/bin/

# Step 7: Clean up temporary files
rm -f lazygit.tar.gz lazygit

# Step 8: Verify installation
if command -v lazygit &>/dev/null; then
  echo "lazygit successfully installed!"
  lazygit --version
else
  echo "Error: lazygit installation failed."
  exit 1
fi

