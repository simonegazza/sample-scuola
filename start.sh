#! /bin/bash

while ! mysql -h db -u root -p$MYSQL_ROOT_PASSWORD -e ";"; do
    sleep 3
done

if ! mysql -h db -u root -p$MYSQL_ROOT_PASSWORD -e "use joomla;"; then
    mysql -h db -u root -p$MYSQL_ROOT_PASSWORD < /home/dump.sql
fi;

service php7.2-fpm start
service nginx start
/bin/bash