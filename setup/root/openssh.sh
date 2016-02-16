#!/bin/bash

# if ssh keys do not exist then generate
if [ ! -f /etc/ssh/ssh_host_key ]; then

	#generate keys for ssh
	/usr/bin/ssh-keygen -A

fi

# run openssh
/usr/bin/sshd -D