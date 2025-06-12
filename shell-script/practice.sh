#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if ["$(id -u)" -ne 0]; then
    echo -e "${R}you are not a root user ${N}"
    exit 1
fi

VALIDATE(){
    if [ "$1" -eq 0 ]
    then
        echo -e "$G Installing $2 is on process $N"
    else
        echo -e "$R Installing $2 is FAILED $n"
        exit 1
    fi
}

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo -e "$R mysql is not installed ---going to install $N"
    dnf install mysql -y
    VALIDATE $? "mysql"
else
    echo -e "$Y already installed $N"
fi