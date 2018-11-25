FROM debian:stretch

ARG MYSQL_ROOT_PASSWORD

#Update package list
RUN \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y ca-certificates apt-transport-https wget gnupg vim unzip && \
    wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - && \
    echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list && \
    apt-get update -y

#Install dependencies
RUN apt-get install -y php7.2 nginx php7.2-fpm php7.2-mysql php7.2-json php7.2-opcache php7.2-readline php7.2-gd php7.2-intl \
    php7.2-curl php7.2-zip libbz2-dev libjpeg-dev libldap2-dev libmemcached-dev libpng-dev libpq-dev php7.2-xml composer mysql-client

#Install joomla
RUN composer global require joomlatools/console --no-interaction && \
    ~/.composer/vendor/bin/joomla site:download --www=/var/www/html --release=3.9 sample-scuola && \
    ~/.composer/vendor/bin/joomla site:install --www=/var/www/html --mysql-login=root:$MYSQL_ROOT_PASSWORD --mysql-host=db --mysql-database=joomla --skip-exists-check sample-scuola

#Install and enable memcached extension
RUN apt-get install -y gcc make autoconf libc-dev pkg-config zlib1g-dev libmemcached-dev php-pear php7.2-dev && \
    echo "no --disable-memcached-sasl" | pecl install memcached && \
    echo extension=memcached.so > /etc/php/7.2/fpm/conf.d/memcached.ini && \
    sed -i -e "s/caching = '0'/caching = '2'/g" /var/www/html/sample-scuola/configuration.php && \
    sed -i -e "s/cache_handler = 'file'/cache_handler = 'memcached'/g" /var/www/html/sample-scuola/configuration.php && \
    sed -i -e "s/memcached_server_host = 'localhost'/memcached_server_host = 'cache'/g" /var/www/html/sample-scuola/configuration.php

COPY nginx/default /etc/nginx/sites-available/default

EXPOSE 80

CMD service php7.2-fpm start && service nginx start && /bin/bash