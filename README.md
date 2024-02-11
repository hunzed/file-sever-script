# file-sever-script

Bash script based project

1. Server (VM1)
a. Create a welcome page and add the welcome message.
b. Create a webpage that can be accessed only after successfully logging in to the
webserver. This task assumes that you create user accounts on the webserver.
c. The server should log all access attempts, successful and unsuccessful.
d. Configure SSHD server such that clients can access the webserver via their local
accounts, using username and password.
e. Configure SFTP server such that clients can upload/download files on the server
machine.
f. Configure local DNS on the server VM such that 8.8.8.8, or 8.8.4.4 is used as the default
DNS server permanently.
2. Clients (VM2 and VM3)
a. Configure/Enable SSH client to be able to access the webserver via network.
b. Configure/Enable SFTP client to be able to upload/download files on the server.
c. Continually test connectivity to VM1 (server VM) by using ping every 5 minutes. Store by
using SCP the file named “connectivity” in VM1 under /home/username/heartbeat folder.
The file should contain all connectivity tests.
d. The client should store a new file every hour on VM1 (the server) by using SCP the
following information: Disk usage, CPU usage, Memory usage, Current running processes,
and Network utilization. The information should be stored under
/home/username/usageinformation/, and the file should be named with the current time
(day-hour-minutes-seconds).
e. Configure SFTP such that clients can upload/download all the labs sheets on their
reserved location at VM1 (server).
f. Configure local DNS on each client VM such that 8.8.8.8, or 8.8.4.4 is used as the default
DNS server permanently.