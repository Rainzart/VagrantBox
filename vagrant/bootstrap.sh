#!/usr/bin/env bash

# Setting variables
DIR="/var/www/vagrant"
DIR_SERVICES=$DIR"/services"

echo '[Set IPv4 default]'
sed -i -e 's/#precedence ::ffff:0:0\/96  100/precedence ::ffff:0:0\/96  100/g' /etc/gai.conf
 

echo '[Updating Ubuntu Server]'
#add-apt-repository -y ppa:ondrej/php
apt-get -y install aptitude
aptitude -y update
aptitude -y upgrade
aptitude -y dist-upgrade

aptitude -y install libxrender1 
aptitude -y install language-pack-pt 
#dpkg-reconfigure locales
echo '[Installing Scripts]'
cp $DIR/cmd/addvhost.sh /usr/local/bin/addvhost

echo '[Installing Apache]'
bash $DIR_SERVICES"/apache.sh"

echo '[Installing PHP]'
bash $DIR_SERVICES"/php.sh"

echo '[Installing MySQL]'
bash $DIR_SERVICES"/mysql.sh" $DIR_SERVICES

echo '[Restarting the services]'
bash $DIR_SERVICES"/restart.sh"