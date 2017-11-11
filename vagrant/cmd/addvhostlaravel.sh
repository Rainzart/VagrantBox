#!/usr/bin/env bash

echo "Criando vhost ${1}..."

DIR_ATUAL=$(pwd)
DIR_HTDOCS="/var/www"
DIR_APACHE="/etc/apache2"
DIR_APACHE_ENABLE=$DIR_APACHE"/sites-enabled"
DIR_APACHE_AVAILABLE=$DIR_APACHE"/sites-available"
FILE=${1} 
HOSTS_FILE="/etc/hosts"

if [ -f $DIR_APACHE_ENABLE/$FILE.dev.conf ]; then
	echo "O vhost $FILE j? existe!"
    exit
fi

VHOST=$(cat <<EOF
<VirtualHost *:80> 
    ServerName $FILE.dev
    DocumentRoot "/var/www/$FILE/public"
        
    # This should be omitted in the production environment
    SetEnv APPLICATION_ENV development
    ErrorLog /var/log/apache2/error-$FILE.log
    LogLevel warn
	
    #Alias /docs /var/www/$FILE/docs
    #<Directory "/var/www/$FILE/docs">
    #    Options Indexes FollowSymLinks
    #    AllowOverride All
    #    Order allow,deny
    #    Allow from all
    #</Directory>
	
    <Directory "/var/www/$FILE/public">
        Options Indexes MultiViews FollowSymLinks
        AllowOverride All 
        Order allow,deny
        Allow from all
    </Directory>
</VirtualHost>
EOF
)

echo "${VHOST}" > $DIR_APACHE_AVAILABLE/$FILE.dev.conf
ln -sf $DIR_APACHE_AVAILABLE/$FILE.dev.conf $DIR_APACHE_ENABLE/$FILE.dev.conf

HOSTS=$(cat <<EOF
127.0.0.1   $FILE.dev
EOF
)
echo "${HOSTS}" >> $HOSTS_FILE

service apache2 restart