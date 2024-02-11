#!/bin/bash
client_usernames=("client1" "client2")

for username in "${client_usernames[@]}"; do
sudo adduser "$username"
echo "$username:1234" | sudo chpasswd
sudo usermod -aGwheel "$username"
sudo mkdir /home/$username/labsheets
sudo chown $username:$username /home/$username/labsheets
sudo chmod 755 /home/$username/labsheets

done

sudo dnf install -y httpd

sudo hostnamectl set-hostname mainframe

sudo dnf install -y openssh-server
sudo systemctl enable sshd
sudo systemctl start sshd

sudo echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf

sudo systemctl restart httpd

sudo cp index.html /var/www/html
sudo systemctl stop firewalld
echo "Server Setup & Config complete"
echo
echo

echo "My IP is $(ip add | grep "inet 192" | awk '{print$2}') and username is $(whoami)"
echo
echo
