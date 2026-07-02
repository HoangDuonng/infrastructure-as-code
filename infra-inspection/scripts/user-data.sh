#!/bin/bash

# Setup Docker and Docker Compose on Vultr

set -e

echo "Starting user data script..."

# System update
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get upgrade -y

# Dependencies
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    git \
    vim \
    htop

# Install Docker
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt-get update -y
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

# Standalone Docker Compose (Optional)
# if ! command -v docker-compose &> /dev/null; then
#     echo "Installing Docker Compose standalone..."
#     curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#     chmod +x /usr/local/bin/docker-compose
# fi

# Service control
systemctl start docker || true
systemctl enable docker

# Docker group membership
if id "ubuntu" &>/dev/null; then
    usermod -aG docker ubuntu
elif id "debian" &>/dev/null; then
    usermod -aG docker debian
fi

# Directories
mkdir -p /srv/app/nginx
mkdir -p /srv/app/logs

# Firewall (UFW)
if command -v ufw &> /dev/null; then
    echo "Configuring firewall..."
    ufw --force enable
    ufw allow 22/tcp
    ufw allow 80/tcp
    ufw allow 443/tcp
    ufw reload
fi

# Fail2ban
apt-get install -y fail2ban
systemctl enable fail2ban
systemctl start fail2ban

echo "User data script completed successfully!"
echo "Docker version: $(docker --version)"

# Verify Docker Compose
if docker compose version &> /dev/null; then
    echo "Docker Compose (plugin) version: $(docker compose version)"
elif command -v docker-compose &> /dev/null; then
    echo "Docker Compose (standalone) version: $(docker-compose --version)"
else
    echo "Warning: Docker Compose not found!"
fi

echo ""
echo "Setup completed! Server is ready for deployment."
echo "Next steps:"
echo "1. Copy nginx.conf to /srv/app/nginx/nginx.conf"
echo "2. Copy docker-compose.yml to /srv/app/docker-compose.yml"
echo "3. Copy your NextJS code to /srv/app/frontend"
echo "4. Copy your Spring Boot code to /srv/app/backend"
echo "5. Run: cd /srv/app && docker compose up -d"
