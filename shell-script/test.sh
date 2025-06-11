#!/bin/bash

USERID= $(id -u)


if [ $USERID -ne 0]

then
    echo "error please run the root user"

else
    echo "you are a ROOT user"

fi

dnf list install nginx
if [ $? -eq 0 ]
then 
    echo "nginx is not installed ...going to install"
    dnf install nginx -y
else    
    echo "installing nginx"

fi

dnf list install mysql
if [ $? -eq 0 ]
then 
    echo "mysql is not installed ...going to install"
    dnf install nginx -y
else    
    echo "installing mysql"

fi

