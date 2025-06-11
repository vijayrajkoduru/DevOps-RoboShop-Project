#!/bin/bash

USERID= $(id -u)


if [ $USERID -ne 0]

then
    echo "error please run the root user"

else
    echo "you are a ROOT user"

fi

dnf list remove mysql
if [ $? -ne 0 ]
then 
    echo "mysql is not installed ...going to install"
    dnf remove mysql -y
    if [ $? -eq 0 ]
    then 
        echo "removed failure "
    fi

else
    echo "mysql removed installed"

fi

dnf list install nginx

if [ $? -ne 0 ]
then 
    echo "nginx is not installed ...going to install"
    dnf remove nginx -y
    if [ $? -eq 0 ]
    then 
        echo "removed nginx"
    fi

else
    echo "nginx removed installed"

fi