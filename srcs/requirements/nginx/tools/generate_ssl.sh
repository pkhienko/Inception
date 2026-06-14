#!/bin/bash

SSL_KEY="/etc/nginx/ssl/nginx-selfsigned.key"
SSL_CRT="/etc/nginx/ssl/nginx-selfsigned.crt"

if [ ! -f "${SSL_KEY}" ] || [ ! -f "${SSL_CRT}" ]; then
    echo "Generate SSL Certificate"

    openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout "${SSL_KEY}" \
        -out "${SSL_CRT}" \
        -subj "/C=TH/ST=Bangkok/L=Bangkok/O=42Bangkok/OU=Inception/CN=${DOMAIN_NAME}"

    echo "Genereted SSL Certificate"
else
	echo "SSL certificate already exists"
fi
