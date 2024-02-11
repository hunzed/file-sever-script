#!/bin/bash
echo "Enter Server IP"
read server_ip
export server_ip
current_user=$(whoami)
export current_user
echo "Enter Server username:"
read server_user
export server_user
sudo dnf install -y openssh-clients
sudo systemctl enable sshd
sudo systemctl start sshd

chmod +x heartbeat.sh
gnome-terminal -- bash -c ./heartbeat.sh

chmod +x usageinfo.sh
gnome-terminal -- bash -c ./usageinfo.sh
# 6. Configure local DNS to use Google DNS.
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf

# Print completion message
echo "Client setup and configuration completed."

# End of script

