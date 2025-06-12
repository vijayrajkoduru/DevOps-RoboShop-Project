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

    if [ $1 -eq 0 ]
    then 
        echo -e " $G installing the mysql $2-----$N"
    else
        echo -e " $R installing the mysql $2-----$N"
}

dnf list installed mysql
    if [ $? -ne -0 ]
    then 
        echo -e "$R mysql inst not instlled ....goint to install it  $N"
        dnf remove mysql -y
        VALIDATE $? "mysql"
     
    else    
        -e "$R already installed $N"
    fi