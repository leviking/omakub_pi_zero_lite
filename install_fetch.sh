set -e

ascii_art='________                  __        ___.
\_____  \   _____ _____  |  | ____ _\_ |__
 /   |   \ /     \\__   \ |  |/ /  |  \ __ \
/    |    \  Y Y  \/ __ \|    <|  |  / \_\ \
\_______  /__|_|  (____  /__|_ \____/|___  /
        \/      \/     \/     \/         \/
'

echo -e "$ascii_art"
echo "=> Omakub zero lite is for fresh pi OS for armv6 installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

#sudo apt-get update >/dev/null
#sudo apt-get update # let's not pipe to dev null
#sudo apt-get install -y git >/dev/null
#sudo apt-get install -y git # also not piping to dev null

echo "Cloning Omakub..."
rm -rf ~/.local/share/omakub
git clone https://github.com/leviking/omakub_pi_zero_lite.git ~/.local/share/omakub >/dev/null
if [[ $OMAKUB_REF != "master" ]]; then
	cd ~/.local/share/omakub
	git fetch origin "${OMAKUB_REF:-stable}" && git checkout "${OMAKUB_REF:-stable}"
	cd -
fi

echo "Installation starting..."
source ~/.local/share/omakub/install.sh
