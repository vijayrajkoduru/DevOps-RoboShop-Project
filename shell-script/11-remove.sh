#!/bin/bash


if [ "$(id -u)" -ne o ]
then 
    echo "please run as a root"
    exit 1
fi

dnf list install nginx

if [ $? -eq 0 ]
then 
    echo "nginx is installed removing "
    dnf remove nginx -y
    if [$? -ne 0 ]
    then 
        echo "failed to remov nginx"
        exit 1
    else
        echo "nginx removing successfully" 
    fi
else
    echo "nginx is not installed"
fi


dnf list installed mysql

if [ $? -eq 0 ]
then 
    echo "removing mysql"
    dnf remove mysql -y
    if [ $? -ne 0 ]
    then
        echo "fail to remove"
        exit 1
    else
            echo "mysql rmoved successfull"
    fi

else
    echo "mysql is not installed"
fi
