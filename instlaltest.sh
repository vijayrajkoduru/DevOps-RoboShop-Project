if [ "$(id -u)" -ne 0 ]
then 
    echo " please enter with root user"
    exit 1
else    
    echo " you already a root user"
fi

validate(){
    if [ "$1" -ne 0 ]; then
        echo "installing $2 ...SUCCESS"
    else    
        echo "install $2 ...FAIL"
        exit 1
    fi
}
softwares=("mysql" "nginx" "python3")

for pkg in "${softwares[@]}"; do

    if dnf list installed "$pkg" &>/dev/null; then
        echo "installing $pkg"
        dnf install "$pkg" -y
        validate $? "$pkg"
    else
        echo "$pkg is already installed"
    fi
done