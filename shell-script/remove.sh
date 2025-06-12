#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ "$(id -u)" -ne 0 ]
then 
    echo -e " $R you are not a root user login with root user $N"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e " $G UNINSTALLING mysql $2-----$N"
    else
        echo -e " $R REMOVED $2-----$N"
    fi
}

dnf list installed mysql
    if [ $? -eq -0 ]
    then 
        echo -e "$R mysql inst not instlled ....goint to install it  $N"
        dnf remove mysql -y
        VALIDATE $? "mysql"
     
    else    
        echo -e "$R NO MYSQL $N"
    fi