#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "You should be root user to run this script"
    exit 1
else
    echo "you are a root user you can run this script"
fi

dnf list install nginx -y

if [ $? -ne 0 ]; then 
    echo "Nginx is not installed, installing now..."
    dnf install nginx -y
    if [ $? -eq 0 ]; then
        echo "Nginx installed successfully"
    else
        echo "Failed to install Nginx"
        exit 1
    fi
else
    echo "Nginx is already installed"
fi