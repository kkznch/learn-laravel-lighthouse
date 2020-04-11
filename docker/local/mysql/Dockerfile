FROM mysql:8.0

COPY ./my.cnf /etc/mysql/conf.d/my.cnf
COPY ./docker-entrypoint-initdb.d/* /docker-entrypoint-initdb.d/
