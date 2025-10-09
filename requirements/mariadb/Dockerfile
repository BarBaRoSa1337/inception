FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
