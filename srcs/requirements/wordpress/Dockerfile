FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y php-fpm php-mysql mariadb-client curl -y && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/local/share/wordpress

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY ./conf/wp-config.php /usr/local/share/wordpress/wp-config.php
COPY ./tools/setup_wordpress.sh /usr/local/bin/setup_wordpress.sh

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x /usr/local/bin/setup_wordpress.sh /usr/local/bin/wp

WORKDIR /var/www/html

ENTRYPOINT ["/usr/local/bin/setup_wordpress.sh"]
