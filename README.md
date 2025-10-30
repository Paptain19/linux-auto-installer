# Linux Auto Installer

An automated setup script for Debian/Ubuntu systems.  
This script installs and configures essential tools, security packages, and basic system updates — ideal for fresh Linux installations or servers.

---

## Features

- ✅ System update and upgrade  
- 🧰 Installation of essential tools (`git`, `curl`, `htop`, `tree`)  
- 🛡️ Firewall configuration with **UFW**  
- 🚨 Brute-force protection with **Fail2Ban**  
- 📝 Full installation logs for easy debugging  

---

## Requirements

- Debian or Ubuntu-based distribution  
- `sudo` privileges (root access required)  
- Internet connection  

---

## Installation & Usage

Clone the repository and make the script executable:

```bash
git clone https://github.com/Paptain19/linux-auto-installer.git
cd linux-auto-installer
chmod +x install.sh
sudo ./install.sh
```

