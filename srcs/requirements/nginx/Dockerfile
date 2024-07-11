FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

RUN apk add --no-cache \
            nginx \
            openssl \
            tini \
            curl

COPY ./conf/nginx.conf            /etc/nginx/http.d/nginx.conf
COPY ./tools/docker-entrypoint.sh	/tmp/docker-entrypoint.sh

RUN chmod +x /tmp/docker-entrypoint.sh

EXPOSE 443

ENTRYPOINT ["tini", "--", "/tmp/docker-entrypoint.sh"]
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]

HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD curl -f https://localhost/ || exit 1