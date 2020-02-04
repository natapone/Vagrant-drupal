#!/bin/bash

PROJECTFOLDER='project'
DB_ROOT_PASS='devel'
DB_USER='devel'
DB_NAME='drupal'
DB_HOST_ACCESS= '%' #'localhost'

# Updating repository

# sudo apt-get -y update

# Installing Apache
sudo apt-get -y install apache2

# Installing PHP and it's dependencies
sudo apt-get -y install php libapache2-mod-php php-dompdf php-gd php-xml php-mbstring php-gettext

# Installing MySQL and it's dependencies, Also, setting up root password for MySQL as it will prompt to enter the password during installation

# Debug PHP log
# $ tail -f /var/log/apache2/error.log

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password ${DB_ROOT_PASS}"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${DB_ROOT_PASS}"
sudo apt-get -y install mysql-server php-mysql

# Creat database
if [ ! -f /var/log/databasesetup ];
then

    echo "CREATE USER '${DB_USER}'@'${DB_HOST_ACCESS}' IDENTIFIED BY '${DB_ROOT_PASS}'" | mysql -uroot -p${DB_ROOT_PASS}
    echo "CREATE DATABASE ${DB_NAME}" | mysql -uroot -p${DB_ROOT_PASS}
    echo "GRANT ALL ON ${DB_NAME}.* TO '${DB_USER}'@'${DB_HOST_ACCESS}'" | mysql -uroot -p${DB_ROOT_PASS}
    echo "flush privileges" | mysql -uroot -p${DB_ROOT_PASS}


    # Enable MySQL external accessible
MSQLCONF=$(cat <<EOF

[mysqld]
bind_address = *
EOF
)
    echo "${MSQLCONF}" >> /etc/mysql/my.cnf
    sudo service mysql restart

    touch /var/log/databasesetup
fi

# setup hosts file, enable clean url rewrite
VHOST=$(cat <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/html/${PROJECTFOLDER}"
    <Directory "/var/www/html/${PROJECTFOLDER}">
        AllowOverride All
        RewriteEngine on
        RewriteBase /
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        RewriteRule ^(.*)$ index.php?q=$1 [L,QSA]
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

# enable mod_rewrite
sudo a2enmod rewrite

# restart apache
service apache2 restart
