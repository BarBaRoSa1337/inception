FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php-fpm php-mysql curl wget tar \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php && \
    chown -R www-data:www-data /run/php

WORKDIR /var/www/wordpress

RUN curl -o /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xzf /tmp/wordpress.tar.gz -C /var/www/ \
    && rm /tmp/wordpress.tar.gz

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
