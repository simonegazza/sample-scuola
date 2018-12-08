#! /bin/bash


while ! mysql -h $MYSQL_DB_HOST -u root -p$MYSQL_ROOT_PASSWORD -e ";"; do
    sleep 3
done

echo "Connected to db"

if ! mysql -h $MYSQL_DB_HOST -u root -p$MYSQL_ROOT_PASSWORD -e "use $MYSQL_DB_NAME;"; then
  echo "initialization"
  
  if ! [ -d "/var/www/html/$SITE_NAME" ]; then
    ~/.composer/vendor/bin/joomla site:download --www=/var/www/html --release=3.9 $SITE_NAME
    ~/.composer/vendor/bin/joomla site:install --www=/var/www/html --mysql-login=root:$MYSQL_ROOT_PASSWORD --mysql-host=$MYSQL_DB_HOST --mysql-database=$MYSQL_DB_NAME --skip-exists-check $SITE_NAME
  fi
  
  cp /home/dump.sql "/home/$MYSQL_DB_NAME.sql"
  sed -i -e "s/MYSQL_DB_NAME/$MYSQL_DB_NAME/g" "/home/$MYSQL_DB_NAME.sql"
  mysql -h $MYSQL_DB_HOST -u root -p$MYSQL_ROOT_PASSWORD < "/home/$MYSQL_DB_NAME.sql"
  rm "/home/$MYSQL_DB_NAME.sql"
  
  rm /etc/nginx/sites-available/default
  cp /home/nginx /etc/nginx/sites-available/default
  sed -i -e "s/SITE_NAME/$SITE_NAME/g" /etc/nginx/sites-available/default
  
  echo "completed"
fi;

service php7.2-fpm start
service nginx start
/bin/bash
