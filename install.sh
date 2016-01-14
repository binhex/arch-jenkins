#!/bin/bash

# exit script if return code != 0
set -e

# define pacman packages
pacman_packages="git unzip unrar jenkins openssh"

# install pre-reqs
pacman -Syu --ignore filesystem --noconfirm
pacman -S --needed $pacman_packages --noconfirm

# set permissions
chown -R nobody:users /usr/share/java/jenkins/ /etc/conf.d/jenkins /var/cache/jenkins/
chmod -R 775 /usr/share/java/jenkins/ /etc/conf.d/jenkins /var/cache/jenkins/

# set password for root user
echo 'root:Jenkins' | chpasswd
 
# fix sshd for docker usage
sed -i -e 's/^UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# cleanup
yes|pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /tmp/*