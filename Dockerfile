FROM ubuntu:trusty
MAINTAINER Fernando Mayo <fernando@tutum.co>

# Install packages
RUN apt-get install -y software-properties-common
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN add-apt-repository 'deb http://mirror.netcologne.de/mariadb/repo/10.0/ubuntu trusty main'
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor mariadb-server pwgen

# Add image configuration and scripts
ADD start.sh /start.sh
ADD run.sh /run.sh
ADD supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf
ADD import_sql.sh /import_sql.sh
RUN chmod 755 /*.sh

VOLUME /var/lib/mysql

EXPOSE 3306
CMD ["/run.sh"]
