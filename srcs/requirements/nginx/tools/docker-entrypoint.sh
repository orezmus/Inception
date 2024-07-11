#!/bin/ash

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
    openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=IT/ST=Florence/L=Florence/O=42Firenze/OU=sum/CN=sum.42.fr" \
            -keyout /etc/ssl/private/sum.42.fr.key \
            -out /etc/ssl/certs/sum.42.fr.crt
fi

exec "$@"