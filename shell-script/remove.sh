#!/bin/bash

USERID=$(id -u)

if [USERID -ne o]
then 
    echo "please run as a root"
    exit 1
else
    echo "already you are running on root user"
fi

dnf lista remove nginx

if [ $? -eq 0 ]
then 
    echo "nginx is installed removing "
    dnf remove nginx -y
    if [$? -ne 0 ]
    then 
        echo "failed to remov nginx"
    else
        echo "nginx removing successfully"
        exit 1
    fi
else
    echo "nginx is not installed"
fi


dnf remove mysql

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
