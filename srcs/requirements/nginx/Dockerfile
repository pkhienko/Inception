FROM debian:bookworm

RUN apt-get update && \
    apt-get install nginx openssl procps -y && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

COPY ./conf/default /etc/nginx/sites-available/default
COPY ./tools/setup_nginx.sh /usr/local/bin/setup_nginx.sh
COPY ./tools/generate_ssl.sh /usr/local/bin/generate_ssl.sh

RUN chmod +x /usr/local/bin/setup_nginx.sh /usr/local/bin/generate_ssl.sh

ENTRYPOINT ["/usr/local/bin/setup_nginx.sh"]
