FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

# RUN mkdir -p /run/mysqld && \
#     chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
