# Base images 基础镜像，官方 https://github.com/docker-library/mysql/blob/master/8.0/Dockerfile
FROM debian:stretch-slim


#MAINTAINER 维护者信息
MAINTAINER cffycls@foxmail.com

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
            # for MYSQL_RANDOM_ROOT_PASSWORD
    		pwgen \
            # for mysql_ssl_rsa_setup
    		openssl \
    		perl \
	&& rm -rf /var/lib/apt/lists/* \
	&& groupadd -r mysql && useradd -r -g mysql mysql

ENV MYSQL_MAJOR 8.0
ENV MYSQL_VERSION 8.0.16-2debian9

RUN echo "deb http://repo.mysql.com/apt/debian/ stretch mysql-${MYSQL_MAJOR}" > /etc/apt/sources.list.d/mysql.list
RUN { \
		echo mysql-community-server mysql-community-server/data-dir select ''; \
		echo mysql-community-server mysql-community-server/root-pass password ''; \
		echo mysql-community-server mysql-community-server/re-root-pass password ''; \
		echo mysql-community-server mysql-community-server/remove-test-db select false; \
	} | debconf-set-selections \
	&& apt-get update && apt-get install -y mysql-community-client="${MYSQL_VERSION}" mysql-community-server-core="${MYSQL_VERSION}" && rm -rf /var/lib/apt/lists/* \
	&& rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
# ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
	&& chmod 777 /var/run/mysqld


RUN set -x \
    && apt-get wget libaio1 apt-utils && wget "$MYSQL_URL" && mkdir /mysql_install \
    && tar -xf mysql-server_8.0.15-1debian9_amd64.deb-bundle.tar -C /mysql_install && cd /mysql_install \
    && groupadd -r mysql && useradd -r -g mysql mysql \
    && mkdir -p "/usr/local/mysql/data" && chown -R mysql:mysql "/usr/local/mysql/" \
    && dpkg-preconfigure mysql-community-server_*.deb \
    && ./bin/mysqld --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --initialize \

    && apt-get install -y --no-install-recommends dirmngr \
        wget \
        pwgen \
        openssl \
        perl5.2.0 \
    && rm -rf /var/lib/apt/lists/* \
    && echo "deb http://repo.mysql.com/apt/debian/ stretch mysql-${MYSQL_MAJOR}" > /etc/apt/sources.list.d/mysql.list \
    \
    && { \
    echo mysql-community-server mysql-community-server/data-dir select ''; \
    echo mysql-community-server mysql-community-server/root-pass password ''; \
    echo mysql-community-server mysql-community-server/re-root-pass password ''; \
    echo mysql-community-server mysql-community-server/remove-test-db select false; \
    } | debconf-set-selections \
    && apt-get install -y mysql-community-client="${MYSQL_VERSION}" mysql-community-server-core="${MYSQL_VERSION}" \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld


VOLUME ["/var/lib/mysql"]
COPY config/ /etc/mysql/
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3306 33060
CMD ["mysqld"]

#  docker run --name mysql -p 3306:3306 -v /your_real_path/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456  -d mysql
