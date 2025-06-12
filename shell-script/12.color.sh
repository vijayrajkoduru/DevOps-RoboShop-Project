#!/bin/bash

# Color definitions
R="\e[31m"  # Red
G="\e[32m"  # Green
Y="\e[33m"  # Yellow
N="\e[0m"   # Normal (reset)

# Check for root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${R}ERROR: Please run this script with root access${N}"
    exit 1
else
    echo -e "${G}You are running with root access${N}"
fi

# Function to validate command execution
VALIDATE() {
    if [ "$1" -eq 0 ]; then
        echo -e "Installation of $2 ... ${G}SUCCESS${N}"
    else
        echo -e "Installation of $2 ... ${R}FAILURE${N}"
        exit 1
    fi
}

# Function to install package if not installed
install_package() {
    local package="$1"
    dnf list installed "$package" &>/dev/null
    if [ $? -ne 0 ]; then
        echo "Installing $package..."
        dnf install "$package" -y
        VALIDATE $? "$package"
    else
        echo -e "$package ... ${Y}already installed${N}"
    fi
}

# Main installation process
packages=("mysql" "python3" "nginx" "git")  # Add more packages as needed

for pkg in "${packages[@]}"; do
    install_package "$pkg"
done

# Additional configuration can go here
echo -e "${G}All packages installed successfully${N}"