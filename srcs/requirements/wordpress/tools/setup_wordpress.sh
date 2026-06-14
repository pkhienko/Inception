#!/bin/bash

DB_PWD=$(cat /run/secrets/db_pwd)
WP_USER_PWD=$(cat /run/secrets/wp_user_pwd)
WP_ADMIN_PWD=$(cat /run/secrets/wp_admin_pwd)

mkdir -p /run/php
chown -R www-data:www-data /run/php /var/www/html

cd /var/www/html

if [ ! -f wp-settings.php ]; then
    echo "Download WordPress core"

    wp core download --allow-root --path=/var/www/html
    rm -rf /var/www/html/wp-config-sample.php
fi

if [ ! -f wp-config.php ]; then
    echo "Copy wp-config.php"
    
    cp /usr/local/share/wordpress/wp-config.php /var/www/html/wp-config.php
fi

echo "Wait MariaDB"
until mariadb -h"${DB_HOST}" -u"${DB_USER}" -p"${DB_PWD}" -e "SELECT 1;"; do
    sleep 1
done

if ! wp core is-installed --allow-root --path=/var/www/html; then
    echo "Install WordPress"

    wp core install --allow-root \
        --url="https://${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --admin_password="${WP_ADMIN_PWD}" \
        --skip-email \
        --path=/var/www/html
else
    echo "WordPress already installed"
fi

if ! wp user get "${WP_USER}" --allow-root --path=/var/www/html; then
    echo "Create WordPress user"

    wp user create --allow-root \
        "${WP_USER}" "${WP_USER_EMAIL}" \
        --role=author \
        --user_pass="${WP_USER_PWD}" \
        --path=/var/www/html
else
    echo "WordPress user already exists"
fi

exec php-fpm8.2 -F
