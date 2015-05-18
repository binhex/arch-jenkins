#!/bin/bash

# define pacman packages
pacman_packages="jenkins git unzip unrar sudo"

# install pre-reqs
pacman -Sy --noconfirm
pacman -S --needed $pacman_packages --noconfirm

# add wheel group to sudoers with no password
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# add user nobody to wheel group
usermod -G10 nobody

# set permissions
chown -R nobody:users /usr/share/java/jenkins/ /etc/conf.d/jenkins /var/cache/jenkins/
chmod -R 775 /usr/share/java/jenkins/ /etc/conf.d/jenkins /var/cache/jenkins/

# cleanup
yes|pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /tmp/*
