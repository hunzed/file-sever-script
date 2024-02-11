#!/bin/bash

#Create variables of paths for ssh & scp
local_usage_directory="/home/$current_user/usageinformation"
remote_usage_directory="/home/$server_user/usageinformation"
password="1234"

#Check if the local directory exists
if [ ! -d "$local_usage_directory" ]; then
    mkdir -p "$local_usage_directory"
    echo "Local directory '$local_usage_directory' created."
fi

#Check if the directory exists on the remote location
    if ! sshpass -p "1234" ssh "$server_user"@"$server_ip" "[  -d '$remote_usage_directory' ]"; then
    sshpass -p "1234" ssh "$server_user"@"$server_ip" "mkdir -p '$remote_usage_directory'"
    echo "Remote directory '$remote_usage_directory' created on $server_ip."
fi

while true; do
    timestamp=$(date +"%Y-%m-%d-%H-%M-%S")
    result_file="$local_usage_directory/usage-$timestamp.txt"

    echo 'Disk Usage:' >> $result_file; df >> $result_file; 
    echo 'CPU Usage:' >> $result_file; top -bn1 | grep 'Cpu(s)' >> $result_file; 
    echo 'Memory Usage:' >> $result_file; free -m >> $result_file; 
    echo 'Running Processes:' >> $result_file; ps aux >> $result_file; 
    echo 'Network Utilization:' >> $result_file; ifstat >> $result_file
    
    sshpass -p "$password" scp "$result_file" "$server_user"@"$server_ip":"$remote_usage_directory/"
    echo "Usage information saved to server, will repeat after 1 hour!"
    sleep 3600  # Sleep for 1 hour before the next iteration
done

