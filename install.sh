# Exit immediately if a command exits with a non-zero status
set -e

# Desktop software and tweaks will only be installed if we're running Gnome
# RUNNING_GNOME=$([[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]] && echo true || echo false)
IS_RASPBIAN_LITE=$([[ -f /etc/os-release && $(grep -q "ID=raspbian" /etc/os-release) && -z "$XDG_CURRENT_DESKTOP" ]] && echo true || echo false)

# Check the distribution name and version and abort if incompatible
# source ~/.local/share/omakub/install/check-version.sh

if $IS_RASPBIAN_LITE; then
  echo "Detected Raspbian Lite. Only installing terminal tools..."
else
  echo "This script is designed to run on Raspbian Lite only. Exiting..."
  exit 1
fi

# Install terminal tools
source ~/.local/share/omakub/install/terminal.sh

