#!/usr/bin/env bash

aptitude install -y php php-cli php-mysql php-mbstring php-dom php-zip php-imagick php-gd php-mcrypt php-pear libapache2-mod-php


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