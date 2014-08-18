FROM phusion/baseimage:0.9.12

ENV HOME /root

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]

# Some Environment Variables
ENV DEBIAN_FRONTEND noninteractive

# Teamspeak 3/MySQL database variables
ENV TS3_MYSQL_HOST 127.0.0.1
ENV TS3_MYSQL_PORT 3306
ENV TS3_MYSQL_DB ts3
ENV TS3_MYSQL_USER ts3
ENV TS3_MYSQL_PASS password

RUN apt-get update
RUN apt-get install -y wget mysql-common

# Downloading and extracting Teamspeak3
RUN wget -P /tmp http://dl.4players.de/ts/releases/3.0.10.3/teamspeak3-server_linux-amd64-3.0.10.3.tar.gz
RUN mkdir /tmp/teamspeak3-server_linux-amd64
RUN tar zxf /tmp/teamspeak3-server_linux-amd64-3.0.10.3.tar.gz -C /tmp/teamspeak3-server_linux-amd64
RUN mv /tmp/teamspeak3-server_linux-amd64/teamspeak3-server_linux-amd64 /opt/teamspeak

# Configuring Teamspeak3 and MySQL connectivity
RUN wget -P /tmp http://archive.debian.org/debian/pool/main/m/mysql-dfsg-5.0/libmysqlclient15off_5.0.51a-24+lenny5_amd64.deb
RUN dpkg -i /tmp/libmysqlclient15off_5.0.51a-24+lenny5_amd64.deb

ADD build/libts3db_mysql.so /opt/teamspeak/libts3db_mysql.so
ADD build/ts3db_mysql.ini /opt/teamspeak/ts3db_mysql.ini

ADD build/ts3server.ini /opt/teamspeak/ts3server.ini

# Installing Teamspeak3 runit entry
RUN mkdir /etc/service/teamspeak
ADD runit/teamspeak.sh /etc/service/teamspeak/run
RUN chmod +x /etc/service/teamspeak/run

# Exposing Teamspeak3 ports
EXPOSE 9987/udp
EXPOSE 10011
EXPOSE 30033

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*