#!/usr/bin/env bash

aptitude install -y apache2
a2enmod rewrite
a2enmod headers

echo '[Trocando DocumentRoot do localhost]'
sed -i -e 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www/g' /etc/apache2/sites-available/000-default.conf