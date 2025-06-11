#!/bin/bash

: << 'COMMENT'
Rule of Thumb:
if [ $? -eq 0 ] → "Is installed?" → Remove if true.
if [ $? -ne 0 ] → "Not installed?" → Install if true.
COMMENT

USERID= $(id -u)


if [ $USERID -ne 0]

then
    echo "error please run the root user"

else
    echo "you are a ROOT user"

fi

dnf install nginx -y

if [ $? -ne 0 ]
then 
    echo "install the nginx now"  : << 'COMMENT'
    dnf install nginx -y
    if [ $? -eq 0 ]
    then 
        echo "installing nginx"
    else    
        echo "failed to instll"
    fi
else    
    echo "already installed"
fi
