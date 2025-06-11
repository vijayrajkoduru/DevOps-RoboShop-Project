#!/bin/bash

USERID= $(id -u)


if [ $USERID -ne 0]

then
    echo "error please run the root user"

else
    echo "you are a ROOT user"

fi

dnf list install mysql
if [ $? -ne 0 ]
then 
    echo "mysql is not installed ...going to install"
    dnf install mysql -y
    if [ $? -eq 0 ]
    then 
        echo "installing mysql"
    else
        echo "installation failure "
    fi

else
    echo "mysql already installed"

fi

dnf list install nginx

if [ $? -ne 0 ]
then 
    echo "nginx is not installed ...going to install"
    dnf install nginx -y
    if [ $? -eq 0 ]
    then 
        echo "installing nginx"
    else
       echo "installation failure "
    fi

else
    echo "nginx already installed"

fi