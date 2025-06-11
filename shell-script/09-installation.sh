#!/bin/bash

USERID=$(id -u)

if [ $USERID -NE 0 ];then
    echo "You should be root user to run this script"
    exit 1
fi

dnf installing nginx -y
if [ $? -ne 0 ]; then
    echo "failed to intall nginx"
    exit 1
fi
dnf install nginx -y
if [ $? -eq o]; then 
    echo "Nginx installed successfully"
else
    echo "Failed to install Nginx"
    exit 1
fi

else 
    echo "Nginx is already installed"
fi