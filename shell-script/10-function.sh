#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: Please run this script with root access"
    exit 1 
else
    echo "You are running with root access"
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo "$1 is ... SUCCESS"
    else
        echo "$1 is ... FAILURE"
        exit 1
    fi

}

dnf list installed nginx
if [ $? -ne 0 ]
then
    echo "nginx is not installed... going to install it"
    dnf install nginx -y
    VALIDATE $? "nginx installation"
    
else
    echo "nginx is already installed...Nothing to do"
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo "mysql is not installed... going to install it"
    dnf install mysql -y
    VALIDATE $? "mysql installation"
    
else
    echo "mysql is already installed...Nothing to do"
fi

dnf list installed python3
if [ $? -ne 0 ]
then
    echo "python3 is not installed... going to install it"
    dnf install python3 -y
    VALIDATE $? "python3"
else
    echo "python3 is already installed...Nothing to do"
fi