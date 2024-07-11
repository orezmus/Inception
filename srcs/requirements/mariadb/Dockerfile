FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

RUN apk add --no-cache \
			mariadb \
			mariadb-client \
			tini

COPY ./conf/mariadb-server.cnf		/etc/my.cnf.d/mariadb-server.cnf
COPY ./tools/docker-entrypoint.sh	/tmp/docker-entrypoint.sh

RUN mkdir -p /run/mysqld/
RUN chmod +x /tmp/docker-entrypoint.sh
RUN chown -R mysql:mysql \
		/run/mysqld/ \
		/tmp/

EXPOSE 3306
  
USER mysql

ENTRYPOINT ["tini", "--", "/tmp/docker-entrypoint.sh"]
CMD ["/usr/bin/mysqld_safe"]

HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD mysqladmin ping -h 127.0.0.1 -u root --silent
