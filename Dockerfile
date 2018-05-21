FROM		centos:6.6
MAINTAINER Mohamed Zaki <mohamed.zaki@aurea.com>

RUN groupadd -r mysql && useradd -r -g mysql mysql


RUN yum -y install which epel-release  http://rpmfind.net/linux/epel/6/i386/Packages/c/crudini-0.9-1.el6.noarch.rpm http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
RUN yum install socat -y curl Percona-XtraDB-Cluster-server-56 Percona-XtraDB-Cluster-client-56 Percona-XtraDB-Cluster-shared-56 percona-toolkit percona-xtrabackup Percona-XtraDB-Cluster-galera-3 rsync nc

RUN sed -ri 's/^user\s/#&/' /etc/my.cnf \
&& rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /var/run/mysqld \
&& chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
&& chmod 777 /var/run/mysqld


VOLUME ["/var/lib/mysql", "/var/log/mysql"]

#RUN sed -Ei '/log-error/s/^/#/g' -i /etc/my.cnf

ADD assets/node.cnf /etc/my.cnf

COPY assets/entrypoint.sh /entrypoint.sh



LABEL vendor=Percona

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306
CMD [""]
