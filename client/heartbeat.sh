#!/bin/bash

local_heartbeat_directory="/home/$current_user/heartbeat"
remote_heartbeat_directory="/home/$server_user/heartbeat"
password="1234"  # Replace with your actual password

# Check if the local directory exists and create it if it doesn't
if [ ! -d "$local_heartbeat_directory" ]; then
    mkdir -p "$local_heartbeat_directory"
    echo "Local directory '$local_heartbeat_directory' created."
fi

# Check if the remote directory exists and create it if it doesn't
if sshpass -p "$password" ssh "$server_user"@"$server_ip" "[ ! -d '$remote_heartbeat_directory' ]"; then
    sshpass -p "$password" ssh "$server_user"@"$server_ip" "mkdir -p '$remote_heartbeat_directory'"
    echo "Remote directory '$remote_heartbeat_directory' created on $server_ip."
fi

while true; do
    timestamp=$(date +"%Y-%m-%d-%H-%M-%S")
    result_file="$local_heartbeat_directory/connectivity-$timestamp.txt"
    
    # Ping the server and save the results to a local file
    ping -c 1 "$server_ip" > "$result_file"

    # Copy the local file to the remote server using scp
    sshpass -p "$password" scp "$result_file" "$server_user"@"$server_ip":"$remote_heartbeat_directory/"

    echo "Ping result saved and copied to the remote server."
    echo "Waiting for 5 minutes to reiterate....." 
    sleep 300  # Sleep for 5 minutes before the next iteration
done

