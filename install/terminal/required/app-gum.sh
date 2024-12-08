# Gum is used for the Omakub commands for tailoring Omakub after the initial install
ARCH=$(uname -m)

if [[ "$ARCH" == "armv6l" ]]; then
  echo "Running on ARMv6 architecture"
  ARCH_SUFFIX="armhf6"
elif [[ "$ARCH" == "armv7l" ]]; then
  echo "Running on ARMv7 architecture"
  echo "you need to make sure this works"
  exit 1
else
  echo "Architecture not recognized as ARMv6 or ARMv7"
  exit 1
fi

cd /tmp
GUM_VERSION="0.14.3" # Use known good version
wget -qO gum.deb "https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/gum_${GUM_VERSION}_${ARCH_SUFFIX}.deb"
sudo apt-get install -y ./gum
rm gum.deb
cd -
