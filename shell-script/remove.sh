#!/bin/bash

USERID=$(id -u)

if [USERID -ne o]
then 
    echo "please run as a root"
else
    echo "already you are running on root user"
fi

dnf lista remove nginx

if [ $? -eq 0 ]
then 
    echo "nginx exist"
    dnf remove nginx -y
    if [$? -ne 0 ]
    then 
        echo "removing the nginx"
    else
        echo "removing failed"
        exit 1
    fi
else
    echo "already removed"
fi

dnf remove mysql -y

if [ $? -eq 0 ]
then 
    echo "instlling mysql"
else
    echo "familed to install"
    exit 1
fi