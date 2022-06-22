# Update server
sudo apt-get update -y 
sudo apt-get upgrade -y

# Allow apt to get packages via HTTPS
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# Add Docker PGP key and verify 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update
sudo apt update -y

# Install Docker 
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Run Docker with SUDO
# Create docker group (may already exist)
#sudo groupadd docker
# Add user to group 
sudo usermod -aG docker ac_admin

