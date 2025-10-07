#!/bin/bash
set -e

# Initialize MariaDB if database directory is empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "[Entrypoint] Initializing database..."
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
fi

# Start MariaDB temporarily
service mariadb start
sleep 4

# Run SQL setup (explicit root login, safer DB/user escaping)
mysql -uroot -p${SQL_ROOT_PASSWORD} <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

# Stop temporary MariaDB
service mariadb stop

# Start MariaDB in foreground
exec mysqld_safe
