#!/bin/bash

# ====================================
# Linux auto installer (Debian/Ubuntu)
# Author : Tristan Divanach
# ====================================

LOG_FILE="logs/install.log"

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
apt install -y git curl htop tree >> $LOG_FILE 2>&1

echo "Firewall configuration..." | tee -a $LOG_FILE
apt install -y ufw >> $LOG_FILE 2>&1
ufw allow OpenSSH >> $LOG_FILE 2>&1
ufw --force enable >> $LOG_FILE 2>&1

echo "Fail2Ban installation..." | tee -a $LOG_FILE
apt install -y fail2ban >> $LOG_FILE 2>&1
systemctl enable fail2ban >> $LOG_FILE 2>&1
systemctl start fail2ban >> $LOG_FILE 2>&1

echo "Installation completed successfully" | tee -a $LOG_FILE
echo "Log file : $LOG_FILE" | tee -a $LOG_FILE
echo "=====================================" | tee -a $LOG_FILE





