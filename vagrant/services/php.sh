#!/usr/bin/env bash

apt update
aptitude install -y php7.2 php7.2-cli php7.2-mysql php7.2-mbstring php7.2-dom php7.2-zip php7.2-gd php7.2-soap
aptitude install -y php-imagick php-mcrypt php-pear


echo '[Installing Composer...]'
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

#echo '[Installing GIT]'
#aptitude install -y git

#echo '[Installing Node/npm/Gulp]'
#curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
#curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
#aptitude install -y nodejs
#aptitude install -y build-essential
#aptitude install -y npm
#aptitude install -y libnotify-bin

#npm install --global gulp-cli
#npm install --global gulp