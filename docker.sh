#!/bin/bash

# function to mount cgroup, required when doing docker in docker
cgroupfs_mount() {
	# see also https://github.com/tianon/cgroupfs-mount/blob/master/cgroupfs-mount
	if grep -v '^#' /etc/fstab | grep -q cgroup \
		|| [ ! -e /proc/cgroups ] \
		|| [ ! -d /sys/fs/cgroup ]; then
		return
	fi
	if ! mountpoint -q /sys/fs/cgroup; then
		mount -t tmpfs -o uid=0,gid=0,mode=0755 cgroup /sys/fs/cgroup
	fi
	(
		cd /sys/fs/cgroup
		for sys in $(awk '!/^#/ { if ($4 == 1) print $1 }' /proc/cgroups); do
			mkdir -p $sys
			if ! mountpoint -q $sys; then
				if ! mount -n -t cgroup -o $sys cgroup $sys; then
					rmdir $sys || true
				fi
			fi
		done
	)
}

# delete docker pid so that docker can start
rm -rf /var/run/docker.pid
 
# run function to mount cgroups
cgroupfs_mount

# run docker daemon and expose api
/usr/bin/docker -d -H 0.0.0.0:4243 -H unix:///var/run/docker.sock