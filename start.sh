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

rm -rf /home/dev/packages
mkdir /home/dev/packages
rm -rf /home/dev/pkg_dev.xml
cp /home/dev/pkg_dev.template.xml /home/dev/pkg_dev.xml

packages=""

for folder in /home/components/*; do
  component="$(basename -- ${folder})"
  echo "recognized $component component"
  ln -s "/home/components/$component" "/home/dev/packages/com_$component"
  packages+="\n\<file type=\"component\" id=\"com_${component}\"\>com_${component}\<\/file\>"
done

for folder in /home/templates/*; do
  template="$(basename -- ${folder})"
  echo "recognized $template template"
  ln -s "/home/templates/$template" "/home/dev/packages/tpl_$template"
  packages+="\n\<file type=\"template\" id=\"${template}\" client=\"site\"\>tpl_${template}\<\/file\>"
done

sed -i "/home/dev/pkg_dev.xml" -e "s/{packages}/${packages}/g" "/home/dev/pkg_dev.xml"

ln -s "/home/dev" "/var/www/html/$SITE_NAME/tmp"

chown -Rh www-data:www-data "/home/components"
chown -Rh www-data:www-data "/home/dev"
chown -Rh www-data:www-data "/home/templates"
chown -Rh www-data:www-data "/var/www/html/$SITE_NAME"

service php7.2-fpm start
service nginx start
/bin/bash
