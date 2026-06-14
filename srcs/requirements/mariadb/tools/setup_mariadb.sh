#!/bin/bash

DB_PWD=$(cat /run/secrets/db_pwd)
DB_ROOT_PWD=$(cat /run/secrets/db_root_pwd)

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Init MariaDB"
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    mariadbd &
    pid="$!"

    until mariadb-admin ping --silent; do
        sleep 1
    done

    mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PWD}';"
    mariadb -uroot -p"${DB_ROOT_PWD}" -e "\
    CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PWD}';
    GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
    FLUSH PRIVILEGES;"

    mariadb-admin -uroot -p"${DB_ROOT_PWD}" shutdown
    wait "$pid"
    echo "Success init MariaDB"
else
    echo "MariaDB already initialized"
fi

exec mariadbd
