#!/bin/bash

# ====================================
# Linux auto installer (Debian/Ubuntu)
# Linux auto installer
# Author : Tristan Divanach
# ====================================

LOG_FILE="logs/install.log"

#Verify if you are root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root (sudo command)." | tee -a $LOG_FILE
    exit 1
fi

echo "=====================================" | tee -a $LOG_FILE
echo "Linux Auto Installer - Start of installation" | tee -a $LOG_FILE
echo "=====================================" | tee -a $LOG_FILE

echo "System update..." | tee -a $LOG_FILE
apt update && apt upgrade -y >> $LOG_FILE 2>&1

echo "Installation of essentials tools..." | tee -a $LOG_FILE

apt install -y git curl htop tree vim >> $LOG_FILE 2>&1

echo "Firewall configuration..." | tee -a $LOG_FILE
apt install -y ufw >> $LOG_FILE 2>&1
ufw allow OpenSSH >> $LOG_FILE 2>&1
ufw --force enable >> $LOG_FILE 2>&1

echo "Fail2Ban installation..." | tee -a $LOG_FILE
apt install -y fail2ban >> $LOG_FILE 2>&1
systemctl enable fail2ban >> $LOG_FILE 2>&1
systemctl start fail2ban >> $LOG_FILE 2>&1

echo "Docker and docker-compose installation..." | tee -a $LOG_FILE
apt install -y docker.io docker-compose >> $LOG_FILE 2>&1
systemctl enable docker >> $LOG_FILE 2>&1
systemctl start docker >> $LOG_FILE 2>&1

echo "Creating it-tools container..." | tee -a $LOG_FILE
cat << EOF > docker-compose.yml
services :
  it-tools:
    image: 'ghcr.io/corentinth/it-tools:latest'
    ports:
        - '7474:80'
    restart: unless-stopped
    container_name: it-tools
    privileged: false
EOF

echo "Installation completed successfully" | tee -a $LOG_FILE
echo "Log file : $LOG_FILE" | tee -a $LOG_FILE
echo "=====================================" | tee -a $LOG_FILE





