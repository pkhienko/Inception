FROM debian:bookworm

RUN apt-get update && \
    apt-get install mariadb-server -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/mysql/*

COPY ./conf/50-client.cnf /etc/mysql/mariadb.conf.d/50-client.cnf
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/setup_mariadb.sh /usr/local/bin/setup_mariadb.sh

RUN chmod +x /usr/local/bin/setup_mariadb.sh

ENTRYPOINT ["/usr/local/bin/setup_mariadb.sh"]
