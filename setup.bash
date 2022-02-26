#!/bin/bash

# run as root

echo "root's password"
passwd root

useradd -m kid
echo "kid's password"
passwd kid

usermod -a -G video,audio daughter

cp -r ./etc /etc
