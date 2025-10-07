FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php-fpm php-mysql mariadb-client curl wget tar \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php && \
    chown -R www-data:www-data /run/php

WORKDIR /var/www/wordpress

RUN curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xzf /tmp/wordpress.tar.gz -C /var/www/ \
    && rm /tmp/wordpress.tar.gz

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = wordpress:9000|g' \
    /etc/php/7.4/fpm/pool.d/www.conf

RUN chown -R www-data:www-data /var/www/wordpress

COPY ./tools/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

CMD ["/tmp/setup.sh"]
