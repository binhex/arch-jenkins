#!/bin/bash

# define pacman packages

# install pre-reqs
pacman -Sy --noconfirm
pacman -S --needed $pacman_packages --noconfirm

# set permissions
chown -R nobody:users /usr/share/java/jenkins/ /etc/conf.d/jenkins /var/cache/jenkins/
chmod -R 775 /usr/share/java/jenkins/ /etc/conf.d/jenkins /var/cache/jenkins/

# cleanup
yes|pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /tmp/*
