#!/usr/bin/env bash

echo "Criando vhost ${1}..."

DIR_ATUAL=$(pwd)
DIR_HTDOCS="/var/www"
DIR_APACHE="/etc/apache2"
DIR_APACHE_ENABLE=$DIR_APACHE"/sites-enabled"
DIR_APACHE_AVAILABLE=$DIR_APACHE"/sites-available"
FILE=${1} 
HOSTS_FILE="/etc/hosts"

if [ -f $DIR_APACHE_ENABLE/$FILE.local.conf ]; then
	echo "O vhost $FILE já existe!"
    exit
fi

VHOST=$(cat <<EOF
<VirtualHost *:80> 
    ServerName $FILE.local
    DocumentRoot "/var/www/$FILE"
        
    # This should be omitted in the production environment
    SetEnv APPLICATION_ENV development
    ErrorLog /var/log/apache2/$FILE-error.log
    LogLevel warn
	
    #Alias /docs /var/www/$FILE/docs
    #<Directory "/var/www/$FILE/docs">
    #    Options Indexes FollowSymLinks
    #    AllowOverride All
    #    Order allow,deny
    #    Allow from all
    #</Directory>
	
    <Directory "/var/www/$FILE">
        Options Indexes MultiViews FollowSymLinks
        AllowOverride All 
        Order allow,deny
        Allow from all
    </Directory>
</VirtualHost>
EOF
)

echo "${VHOST}" > $DIR_APACHE_AVAILABLE/$FILE.local.conf
ln -sf $DIR_APACHE_AVAILABLE/$FILE.local.conf $DIR_APACHE_ENABLE/$FILE.local.conf

HOSTS=$(cat <<EOF
127.0.0.1   $FILE.local
EOF
)
echo "${HOSTS}" >> $HOSTS_FILE

service apache2 restart