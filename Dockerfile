FROM debian:stretch

RUN apt-get update -y && \
apt-get upgrade -y && \
apt-get install -y nginx ca-certificates apt-transport-https wget gnupg mysql-client git

RUN wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - && \
    echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list && \
    apt-get update -y

RUN apt-get install -y php7.2\
    php7.2-dev \
    php7.2-fpm \
    php7.2-mysql \
    php7.2-json \
    php7.2-opcache \
    php7.2-readline \
    php7.2-gd \
    php7.2-intl \
    php7.2-curl \
    php7.2-zip \
    libbz2-dev \
    libjpeg-dev \
    libldap2-dev \
    libmemcached-dev \
    libpng-dev \
    libpq-dev \
    php7.2-xml

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --quiet && \
    mv composer.phar /usr/bin/composer && \
    chmod +x /usr/bin/composer

RUN composer global require joomlatools/console --no-interaction

COPY nginx/default /home/nginx
COPY dev_package /home/dev
COPY pkg_dev.template.xml /home/pkg_dev.template.xml

COPY start.sh /home/start.sh
RUN chmod u+x /home/start.sh
CMD ["/home/start.sh"]
