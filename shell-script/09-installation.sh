#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "You should be root user to run this script"
    exit 1
else
    echo "you are a root user you can run this script"
fi

dnf list install mysql

if [ $? -ne 0 ]; then 
   
    echo "mysql is not installed, installing now..."
    dnf install mysql -y
    if [ $? -eq 0 ]; then
        echo "mysql installed successfully"
    else
        echo "Failed to install mysql"
        exit 1
    fi
else
    echo "mysql is already installed"
fi