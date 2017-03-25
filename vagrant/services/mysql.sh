#!/usr/bin/env bash

#DIR=${1} 

debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

echo '[Install MySQL]'
aptitude install -y mysql-server libapache2-mod-auth-mysql

echo '[Enabling access remote MySQL]'
sed -i -e 's/bind-address/#bind-address/g' /etc/mysql/mysql.conf.d/mysqld.cnf
#sed -i -e 's/skip-external-locking/#skip-external-locking/g' /etc/mysql/my.cnf

echo '[Install MySQL root user!]'
mysql --user=root --password=root --host=localhost --port=3306 < $DIR_SERVICES/mysql_bootstrap.sql