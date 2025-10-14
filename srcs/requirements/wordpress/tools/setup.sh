#!/bin/bash

set -e

if [ ! -d "/run/php/" ]; then
  mkdir /run/php/
fi

sleep 5

cd /var/www/wordpress

wp core download --allow-root

wp config create --allow-root \
  --dbhost=$WP_HOST \
  --dbname=$WP_NAME \
  --dbuser=$WP_USER \
  --dbpass=$WP_PASS

wp core install --allow-root \
  --url=$WP_URL \
  --title=$WP_TITLE \
  --admin_user=$WP_ADMIN_USER \
  --admin_password=$WP_ADMIN_PASSWORD \
  --admin_email=$WP_ADMIN_MAIL

exec php-fpm7.4 -F
