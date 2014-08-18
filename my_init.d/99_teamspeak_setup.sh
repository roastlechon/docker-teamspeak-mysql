#!/usr/bin/env sh

echo "*** Modifying ts3db_mysql.ini with info: host=$TS3_MYSQL_HOST, port=$TS3_MYSQL_PORT,"
echo "**** database=$TS3_MYSQL_DB, username=$TS3_MYSQL_USER, password=$TS3_MYSQL_PASS"

sed -i -e "s/host=127.0.0.1/host=$TS3_MYSQL_HOST/g" /opt/teamspeak/ts3db_mysql.ini
sed -i -e "s/port=3306/port=$TS3_MYSQL_PORT/g" /opt/teamspeak/ts3db_mysql.ini
sed -i -e "s/username=ts3/username=$TS3_MYSQL_USER/g" /opt/teamspeak/ts3db_mysql.ini
sed -i -e "s/password=password/password=$TS3_MYSQL_PASS/g" /opt/teamspeak/ts3db_mysql.ini
sed -i -e "s/database=ts3/database=$TS3_MYSQL_DB/g" /opt/teamspeak/ts3db_mysql.ini