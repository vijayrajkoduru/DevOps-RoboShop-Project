#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: Please run this script with root access"
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

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo "mysql is not installed... going to install it"
    dnf install mysql -y
    if [ $? -eq 0 ]
    then
        echo "Installing mysql is ... SUCCESS"
    else
        echo "Installing mysql is ... FAILURE"
        exit 1
    fi
else
    echo "mysql is already installed...Nothing to do"
fi