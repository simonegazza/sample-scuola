FROM debian:stretch

COPY start.sh /home/start.sh

RUN \
chmod +x /home/start.sh && \
apt-get update -y && \
apt-get upgrade -y && \
apt-get install -y ca-certificates apt-transport-https wget gnupg vim unzip && \
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - && \
echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list && \
apt-get update -y && \
apt-get install -y php7.2 nginx php7.2-fpm php7.2-mysql php7.2-json php7.2-opcache php7.2-readline php7.2-gd php7.2-intl \
                   php7.2-curl php7.2-zip libbz2-dev libjpeg-dev libldap2-dev libmemcached-dev libpng-dev libpq-dev php7.2-xml composer mysql-client && \
composer global require joomlatools/console --no-interaction

COPY nginx/default /home/nginx
COPY mysql/dump.sql /home/dump.sql

EXPOSE 80

CMD ["/home/start.sh"]
