#!/bin/sh

set -e

if [ ! -d "/run/php/" ]; then
  mkdir -p /run/php/
  chown -R www-data:www-data /run/php/
fi

cd /var/www/wordpress

echo "[Entrypoint] Waiting for MariaDB at ${MYSQL_HOST}..."
until wp db check --allow-root --path=/var/www/wordpress > /dev/null 2>&1; do
  sleep 2
done

if [ ! -f wp-config.php ]; then
  echo "[Entrypoint] Generating wp-config.php..."
  wp config create --allow-root \
    --dbname="${MYSQL_DATABASE}" \
    --dbuser="${MYSQL_USER}" \
    --dbpass="${MYSQL_PASSWORD}" \
    --dbhost="${MYSQL_HOST}"
fi

if ! wp core is-installed --allow-root; then
  echo "[Entrypoint] Installing WordPress..."
  wp core install --allow-root \
    --url="${WP_URL}" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}"

  wp user create --allow-root "${WP_USER}" "${WP_EMAIL}" \
    --user_pass="${WP_PASSWORD}" --role=author
fi

echo "[Entrypoint] Starting PHP-FPM..."
exec php-fpm7.4 -F
