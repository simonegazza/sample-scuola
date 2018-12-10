FROM debian:stretch

ARG MYSQL_ROOT_PASSWORD

RUN \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y ca-certificates apt-transport-https wget gnupg vim unzip && \
    wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - && \
    echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list && \
    apt-get update -y

RUN \
    apt-get install -y php7.2 nginx php7.2-fpm php7.2-mysql php7.2-json php7.2-opcache php7.2-readline php7.2-gd \
    php7.2-intl php7.2-curl php7.2-zip libbz2-dev libjpeg-dev libldap2-dev libmemcached-dev libpng-dev libpq-dev \
    php7.2-xml composer mysql-client

RUN \
    composer global require joomlatools/console --no-interaction && \
    ~/.composer/vendor/bin/joomla site:download --www=/var/www/html --release=3.9 sample-scuola && \
    ~/.composer/vendor/bin/joomla site:install --www=/var/www/html --mysql-login=root:$MYSQL_ROOT_PASSWORD --mysql-host=db --mysql-database=joomla --skip-exists-check sample-scuola

RUN chmod -R 755 /var/www/html/ && \
    chown -R www-data:www-data /var/www/html/

COPY nginx/default /etc/nginx/sites-available/default

EXPOSE 80

CMD service php7.2-fpm start && service nginx start && /bin/bash