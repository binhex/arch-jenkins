#!/bin/bash

# exit script if return code != 0
set -e

# build scripts
####

# download build scripts from github
curly.sh -rc 6 -rw 10 -of /tmp/scripts-master.zip -url https://github.com/binhex/scripts/archive/master.zip

# unzip build scripts
unzip /tmp/scripts-master.zip -d /tmp

# move shell scripts to /root
mv /tmp/scripts-master/shell/arch/docker/*.sh /root/

# pacman packages
####

# define pacman packages
pacman_packages="git"

# install compiled packages using pacman
if [[ ! -z "${pacman_packages}" ]]; then
	pacman -S --needed $pacman_packages --noconfirm
fi

# aor packages
####

# define arch official repo (aor) packages
aor_packages="jenkins"

# call aor script (arch official repo)
source /root/aor.sh

# aur packages
####

# define aur packages
aur_packages=""

# call aur install script (arch user repo)
source /root/aur.sh

# container perms
####

# create file with contets of here doc
cat <<'EOF' > /tmp/permissions_heredoc
# set permissions inside container
chown -R "${PUID}":"${PGID}" /usr/share/java/jenkins/ /etc/conf.d/jenkins /home/nobody /var/cache/
chmod -R 775 /usr/share/java/jenkins/ /etc/conf.d/jenkins /home/nobody /var/cache/

EOF

# replace permissions placeholder string with contents of file (here doc)
sed -i '/# PERMISSIONS_PLACEHOLDER/{
    s/# PERMISSIONS_PLACEHOLDER//g
    r /tmp/permissions_heredoc
}' /root/init.sh
rm /tmp/permissions_heredoc

# env vars
####

cat <<'EOF' > /tmp/envvars_heredoc
export JAVA_ARGS=$(echo "${JAVA_ARGS}" | sed -e 's/^[ \t]*//')
if [[ ! -z "${JAVA_ARGS}" ]]; then
	echo "[info] JAVA_ARGS defined as '${JAVA_ARGS}'" | ts '%Y-%m-%d %H:%M:%.S'
else
	echo "[warn] JAVA_ARGS not defined,(via -e JAVA_ARGS), defaulting to '-Xmx512m'" | ts '%Y-%m-%d %H:%M:%.S'
	export JAVA_ARGS="-Xmx512m"
fi

export JAVA_OPTS=$(echo "${JAVA_OPTS}" | sed -e 's/^[ \t]*//')
if [[ ! -z "${JAVA_OPTS}" ]]; then
	echo "[info] JAVA_OPTS defined as '${JAVA_OPTS}'" | ts '%Y-%m-%d %H:%M:%.S'
else
	echo "[warn] JAVA_OPTS not defined,(via -e JAVA_OPTS), defaulting to null value" | ts '%Y-%m-%d %H:%M:%.S'
	export JAVA_OPTS=""
fi

EOF

# replace permissions placeholder string with contents of file (here doc)
sed -i '/# ENVVARS_PLACEHOLDER/{
    s/# ENVVARS_PLACEHOLDER//g
    r /tmp/envvars_heredoc
}' /root/init.sh
rm /tmp/envvars_heredoc

# cleanup
yes|pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /usr/share/gtk-doc/*
rm -rf /tmp/*
