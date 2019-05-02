#!/usr/bin/env bash

aptitude update
aptitude install -y php php-cli php-mysql php-mbstring php-xml php-zip php-gd php-soap php-imagick php-pear

echo '[Installing Composer...]'
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
