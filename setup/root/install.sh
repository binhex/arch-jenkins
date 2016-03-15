#!/bin/bash

# exit script if return code != 0
set -e

# define pacman packages
pacman_packages="git unzip unrar openssh"

# install pre-reqs
pacman -S --needed $pacman_packages --noconfirm

# set password for root user
echo 'root:Jenkins' | chpasswd
 
# fix sshd for docker usage
sed -i -e 's/^UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# call aor script (arch official repo)
source /root/aor.sh

# cleanup
yes|pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /tmp/*