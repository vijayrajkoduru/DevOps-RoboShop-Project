#!/bin/bash

USERID=$(id -u)

if [ $USERIF -NE O ]
then
    echo "please run as a root user"
    exit 1
else
    echo "You are running with root access"
fi

dnf list installed nginx

if [ $? -ne 0 ]
then
    echo "nginx is not installed... going to install it"
    dnf install nginx -y
    if [ $? -eq 0 ]
    then
        echo "Installing nginx is ... SUCCESS"
    else
        echo "Installing nginx is ... FAILURE"
        exit 1
    fi
else
    echo "nginx is already installed...Nothing to do"
fi  