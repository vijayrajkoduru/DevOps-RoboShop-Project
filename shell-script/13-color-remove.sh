#!/bin/bash

# Color definitions
R="\e[31m"  # Red
G="\e[32m"  # Green
Y="\e[33m"  # Yellow
N="\e[0m"   # Normal (reset)

# Protected packages that should never be removed
PROTECTED_PKGS=("dnf" "python3" "rpm")  # Add other critical packages

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

# Function to check if package is protected
is_protected() {
    local pkg="$1"
    for protected in "${PROTECTED_PKGS[@]}"; do
        if [ "$pkg" == "$protected" ]; then
            return 0
        fi
    done
    return 1
}

# Function to remove package if installed
remove_package() {
    local package="$1"
    
    if is_protected "$package"; then
        echo -e "${Y}Skipping protected package: $package${N}"
        return
    fi
    
    dnf list installed "$package" &>/dev/null
    if [ $? -eq 0 ]; then
        echo "Attempting to remove $package..."
        dnf remove "$package" -y --skip-broken 2>/dev/null
        VALIDATE $? "$package" "non-strict"  # Changed to non-strict
    else
        echo -e "$package ... ${Y}not installed${N}"
    fi
}

# Main removal process
packages=("git" "nginx" "mysql" "python3")  # Packages to attempt removing

echo -e "\n${Y}=== Package Removal Process ===${N}"
for pkg in "${packages[@]}"; do
    remove_package "$pkg"
done

# Clean up dependencies (carefully)
echo -e "\n${Y}Cleaning up unused dependencies...${N}"
dnf autoremove -y --skip-broken 2>/dev/null
VALIDATE $? "Dependency cleanup" "non-strict"

echo -e "\n${G}Package removal completed${N}"