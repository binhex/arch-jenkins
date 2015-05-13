#!/bin/bash

# define pacman packages
pacman_packages="jenkins"

# install pre-reqs
pacman -Sy --noconfirm
pacman -S --needed $pacman_packages --noconfirm

# set permissions
chown -R nobody:users /usr/share/java/jenkins/ /etc/conf.d/jenkins
chmod -R 775 /usr/share/java/jenkins/ /etc/conf.d/jenkins

# cleanup
yes|pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /tmp/*
