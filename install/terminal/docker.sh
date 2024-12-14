# Add the official Docker repo
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Give this user privileged Docker access
sudo usermod -aG docker ${USER}

# Limit log size to avoid running out of disk
echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json
