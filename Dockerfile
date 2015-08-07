FROM binhex/arch-base:2015080700
MAINTAINER binhex

# additional files
##################

# add supervisor conf file for app
ADD *.conf /etc/supervisor/conf.d/

# add install bash script
ADD install.sh openssh.sh docker.sh /root/

# add custom environment file for application
ADD jenkins.sh /home/nobody/

# install app
#############

# make executable and run bash scripts to install app
RUN chmod +x /root/*.sh /home/nobody/*.sh && \
	/bin/bash /root/install.sh

# docker settings
#################

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# expose port for http
EXPOSE 8090

# expose port for docker api
EXPOSE 4243

# expose port for ssh
EXPOSE 22

# set environment variables for user nobody
ENV HOME /home/nobody

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]