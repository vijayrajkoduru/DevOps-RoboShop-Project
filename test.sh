if [ "$(id -u)" -ne 0 ]
then 
    echo " please enter with root user"
    exit 1
else    
    echo " you already a root user"
fi

validate(){
    if [ "$1" -eq 0 ]; then
        echo "removing $2 ...SUCCESS"
    else    
        echo "removing $2 ...FAIL"
        exit 1
    fi
}
softwares=("mysql" "nginx" "python3")

for pkg in "${softwares[@]}"; do

    if dnf list installed "$pkg" &>/dev/null; then
        echo "removing $pkg"
        dnf remove "$pkg" -y
        validate $? "$pkg"
    else
        echo "$pkg not installed"
    fi
done