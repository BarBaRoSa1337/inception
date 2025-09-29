FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

RUN mkdir -p /etc/ssl/certs/ && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/certs/barbarosa.42.fr.key -out /etc/ssl/certs/barbarosa.42.fr.cert \
    -subj "/CN=achakour.42.fr"

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
