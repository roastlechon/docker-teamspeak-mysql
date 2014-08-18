# Docker: Teamspeak using MySQL

This is a docker image for setting up Teamspeak with Mysql. This uses [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker) base Ubuntu image, which takes care of [basic necessities any docker container needs.](https://github.com/phusion/baseimage-docker#why-use-baseimage-docker)

## Try it out!

Make sure you have a MySQL database with appropriate user access.

```bash
git clone repo
cd docker-teamspeak-mysql

# Builds a Docker image named "teamspeak-mysql" from the current directory.
sudo docker build -t teamspeak-mysql .

# Creates a new container based on the Docker image "teamspeak-mysql".
sudo docker run -p 9987:9987/udp -p 10011:10011 -p 30033:30033 -e TS3_MYSQL_HOST=172.17.0.5 -e TS3_MYSQL_PASS=password -d teamspeak-mysql /sbin/my_init --enable-insecure-key
```

The last command will bind the container's ports 9987, 10011, and 30033 to the host's ports. Assuming everything went swimmingly, you should be able to connect to the public IP of the host from your Teamspeak client.

* `docker run` - Creates and runs a new Docker container based off an image.
* `-p 9987:9987/udp -p 10011:10011 -p 30033:30033` - Binds the local ports 9987, 10011, and 30033 to the container's ports.
* `-e TS3_MYSQL_HOST=hostname -e TS3_MYSQL_PASS=password` - Uses environmental variables to connect to MySQL.
* `-d teamspeak-mysql` - Uses the image "teamspeak-mysql" to create the Docker container.
* `/sbin/my_init` - Runs the init scripts used to kick off long-running processes and other bootstrapping, as per [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker).
* `--enable-insecure-key` - Enables an insecure key to be able to SSH into the container, as per [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker).

## Usage with a MySQL container

You can use this image in conjunction with a MySQL container and [link them together](http://docs.docker.io/en/latest/use/working_with_links_names/). Note that you must have the MySQL container running first. 

For example:

`sudo docker run -p 9987:9987/udp -p 10011:10011 -p 30033:30033 --link ts3-mysql:ts3-mysql -d teamspeak-mysql /sbin/my_init --enable-insecure-key`

* `--link ts3-mysql:ts3-mysql` - Links the container and specifies the container to link to and the alias. The container to link to and the alias are separated by a colon.

## List of environmental variables
* `TS3_MYSQL_HOST` - Hostname of MySQL database. This assumes that its not running in the same container as Teamspeak, but a remote database (could be different container or on the host itself).
* `TS3_MYSQL_PORT` - Port of MySQL database.
* `TS3_MYSQL_DB` - Name of the database. Default is "ts3".
* `TS3_MYSQL_USER` - Name of the user. Default is "ts3".
* `TS3_MYSQL_PASS` - Password of the user. Default is "password".