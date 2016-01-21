**Application**

[Jenkins](https://jenkins-ci.org/)

**Application description**

Jenkins is an open source continuous integration tool written in Java. The project was forked from Hudson after a dispute with Oracle. Jenkins provides continuous integration services for software development. It is a server-based system running in a servlet container such as Apache Tomcat.

**Build notes**

Latest stable release of Jenkins from Arch Linux Repo.

**Usage**
```
docker run -d \
	--name=<container name> \
	-v <path for config files>:/config \
	-v /etc/localtime:/etc/localtime:ro \
	binhex/arch-jenkins
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

`http://<host ip>:8090`

**Example**
```
docker run -d \
	--name=jenkins \
	-v /apps/docker/get_iplayer:/config \
	-v /etc/localtime:/etc/localtime:ro \
	binhex/arch-jenkins
```

**Notes**

N/A

[Support forum](http://lime-technology.com/forum/index.php?topic=38055.0)