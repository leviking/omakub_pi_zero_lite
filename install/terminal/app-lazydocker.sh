#!/bin/bash

echo "Installing lazydocker for ARMv6..."

# Step 1: Fetch the latest version number from the GitHub API
LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

if [[ -z "$LAZYDOCKER_VERSION" ]]; then
  echo "Error: Unable to fetch the latest version of lazydocker."
  exit 1
fi

# Step 2: Construct the correct download URL for ARMv6
DOWNLOAD_URL="https://github.com/jesseduffield/lazydocker/releases/download/v${LAZYDOCKER_VERSION}/lazydocker_${LAZYDOCKER_VERSION}_Linux_armv6.tar.gz"

# Step 3: Download the tar.gz file
echo "Downloading lazydocker version $LAZYDOCKER_VERSION from $DOWNLOAD_URL..."
curl -sLo lazydocker.tar.gz "$DOWNLOAD_URL"

# Step 4: Verify the download
if [[ ! -f lazydocker.tar.gz ]]; then
  echo "Error: Failed to download lazydocker from $DOWNLOAD_URL."
  exit 1
fi

# Step 5: Extract the binary
echo "Extracting lazydocker..."
tar -xf lazydocker.tar.gz lazydocker

# Step 6: Install the binary to /usr/local/bin
echo "Installing lazydocker to /usr/local/bin..."
sudo install lazydocker /usr/local/bin/

# Step 7: Clean up temporary files
rm -f lazydocker.tar.gz lazydocker

# Step 8: Verify installation
if command -v lazydocker &>/dev/null; then
  echo "lazydocker successfully installed!"
  lazydocker --version
else
  echo "Error: lazydocker installation failed."
  exit 1
fi

