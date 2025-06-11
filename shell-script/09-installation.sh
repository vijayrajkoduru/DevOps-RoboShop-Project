#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "You should be root user to run this script"
    exit 1
fi

dnf list installed mysql

if [ $? -ne 0 ]; then
    echo "MySQL is not installed... going to install it"
    dnf install mysql -y
    if [ $? -eq 0 ]; then
        echo "Installing MySQL is ... SUCCESS"
    else
        echo "Installing MySQL is ... FAILURE"
        exit 1
    fi
else
    echo "MySQL is already installed...Nothing to do"
fi