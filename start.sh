#! /bin/bash

while ! mysql -h $MYSQL_DB_HOST -u root -p$MYSQL_ROOT_PASSWORD -e "SET GLOBAL sql_mode = '';"; do
    sleep 3
done

echo "Connected to db"


if ! [ -f "/var/www/html/$SITE_NAME/configuration.php" ]; then
  ~/.composer/vendor/bin/joomla site:download --www=/var/www/html --release=3.9 $SITE_NAME
  ~/.composer/vendor/bin/joomla site:install --www=/var/www/html --mysql-login=root:$MYSQL_ROOT_PASSWORD --mysql-host=$MYSQL_DB_HOST --mysql-database=$MYSQL_DB_NAME $SITE_NAME
  rm /etc/nginx/sites-available/default
  cp /home/nginx /etc/nginx/sites-available/default
  sed -i -e "s/SITE_NAME/$SITE_NAME/g" /etc/nginx/sites-available/default
fi

for folder in /home/components/*; do
  component="$(basename -- ${folder})"
  echo "$component"
  ln -s "/home/components/$component" "/var/www/html/$SITE_NAME/tmp/$component"
done
cd ~

chown -Rh www-data:www-data "/var/www/html/$SITE_NAME"

service php7.2-fpm start
service nginx start
/bin/bash
