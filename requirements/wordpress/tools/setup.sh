#!/bin/sh

mkdir -p /run/php

sleep 10

cd /var/www/wordpress

wp config create --allow-root \
  --dbname=${MYSQL_DATABASE} \
  --dbuser=${MYSQL_USER} \
  --dbpass=${MYSQL_PASSWORD} \
  --dbhost=${MYSQL_HOST}

wp core install --allow-root \
  --url=${WP_URL} \
  --title=${WP_TITLE} \
  --admin_user=${WP_ADMIN_USER} \
  --admin_password=${WP_ADMIN_PASSWORD} \
  --admin_email=${WP_ADMIN_EMAIL}

wp user create --allow-root "${WP_USER}" "${WP_EMAIL}" \
  --user_pass="${WP_PASSWORD}" --role=author

exec php-fpm7.4 -F
