#!/usr/bin/env bash

# Setting variables
DIR="/var/www/vagrant"
DIR_SERVICES=$DIR"/services"

echo '[Set IPv4 default]'
sed -i -e 's/#precedence ::ffff:0:0\/96  100/precedence ::ffff:0:0\/96  100/g' /etc/gai.conf
 
echo '[Updating Ubuntu Server]'

apt-get -y update && apt-get -y upgrade && apt-get -y dist-upgrade
add-apt-repository ppa:ondrej/php

apt-get -y install aptitude
aptitude -y install python-software-properties
aptitude -y install libxrender1
aptitude -y install language-pack-pt
#dpkg-reconfigure locales
#dpkg-reconfigure tzdata
timedatectl set-timezone America/Sao_Paulo

echo '[Installing Scripts]'
cp $DIR/cmd/addvhost.sh /usr/local/bin/addvhost
cp $DIR/cmd/addvhostlaravel.sh /usr/local/bin/addvhostlaravel

echo '[Installing Apache]'
bash $DIR_SERVICES"/apache.sh"

echo '[Installing PHP]'
bash $DIR_SERVICES"/php.sh"

echo '[Installing MySQL]'
bash $DIR_SERVICES"/mysql.sh" $DIR_SERVICES

echo '[Restarting the services]'
bash $DIR_SERVICES"/restart.sh"