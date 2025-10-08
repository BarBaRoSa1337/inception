FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

RUN  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    # first path
    # -keyout /etc/nginx/ssl/barbarosa.42.fr.key \
    # -out /etc/nginx/ssl/barbarosa.42.fr.crt \
    #second path
    -keyout /etc/ssl/certs/barbarosa.42.fr.key -out /etc/ssl/certs/barbarosa.42.fr.cert \
    -subj "/CN=barbarosa.42.fr"

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
