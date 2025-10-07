#!/bin/bash
set -e

echo "[Entrypoint] Starting MariaDB initialization..."

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "[Entrypoint] Initializing database files..."
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null

    mysqld --user=mysql --skip-networking --bootstrap <<-EOSQL
        CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};
        CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';
        FLUSH PRIVILEGES;
EOSQL
fi

echo "[MariaDB] Starting main server..."
exec mysqld_safe
