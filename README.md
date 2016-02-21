**Application**

[Jenkins](https://jenkins-ci.org/)

**Description**

Jenkins is an open source continuous integration tool written in Java. The project was forked from Hudson after a dispute with Oracle. Jenkins provides continuous integration services for software development. It is a server-based system running in a servlet container such as Apache Tomcat.

**Build notes**

Latest stable release of Jenkins from Arch Linux Repo.

**Usage**
```
docker run -d \
    --name=<container name> \
    -v <path for config files>:/config \
    -v /etc/localtime:/etc/localtime:ro \
    -e PUID=<uid for user> \
    -e PGID=<gid for user> \
    binhex/arch-jenkins
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

`http://<host ip>:8090`

**Example**
```
docker run -d \
    --name=jenkins \
    -v /apps/docker/jenkins:/config \
    -v /etc/localtime:/etc/localtime:ro \
    -e PUID=0 \
    -e PGID=0 \
    binhex/arch-jenkins
```

**Notes**

User ID (PUID) and Group ID (PGID) can be found by issuing the following command for the user you want to run the container as:-

```
id <username>
```
___
If you appreciate my work, then please consider buying me a beer  :D

[![PayPal donation](https://www.paypal.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=MM5E27UX6AUU4)

[Support forum](http://lime-technology.com/forum/index.php?topic=45839.0)