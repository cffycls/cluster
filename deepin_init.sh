#!/bin/bash

apt-get install git -y
cat >> /etc/hosts <<EOF
151.101.185.194 github.global-ssl.fastly.net
192.30.253.112 github.com
EOF
cat /etc/hosts 
/etc/init.d/networking restart

