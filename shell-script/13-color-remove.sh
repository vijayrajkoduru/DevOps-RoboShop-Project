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
fi

# Function to validate command execution
VALIDATE() {
    if [ "$1" -eq 0 ]; then
        echo -e "Removal of $2 ... ${G}SUCCESS${N}"
    else
        echo -e "Removal of $2 ... ${R}FAILURE${N}"
        [ "$3" = "strict" ] && exit 1
    fi
}

# Function to remove package if installed
remove_package() {
    local package="$1"
    dnf list installed "$package" &>/dev/null
    if [ $? -eq 0 ]; then
        echo "Removing $package..."
        dnf remove "$package" -y
        VALIDATE $? "$package" "strict"
    else
        echo -e "$package ... ${Y}not installed${N}"
    fi
}

# Main removal process
packages=("git" "nginx" "mysql")  # Add more packages to remove

echo -e "\n${Y}=== Package Removal Process ===${N}"
for pkg in "${packages[@]}"; do
    remove_package "$pkg"
done

# Clean up dependencies
echo -e "\n${Y}Cleaning up unused dependencies...${N}"
dnf autoremove -y
VALIDATE $? "Dependency cleanup" "non-strict"

echo -e "\n${G}Package removal completed${N}"