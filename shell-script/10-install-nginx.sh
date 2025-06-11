#!/bin/bash

USERID=$(id -u)

if [$USERID -ne 0]
then 
    echo "you should be a root user"
    exit 1
else
    echo "You are a root user"
fi

dnf list install nginx

if [ $? -ne 0 ]
then
    echo "nginx is not installed and going to install it"
    dnf install nginx -y
    if [ $? -eq 0 ]
    then 
        echo "nginx installing is ... SUCESS"
    else
        echo "nginx installing is ... FAILURE"
        exit 1
    fi
else