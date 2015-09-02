#!/bin/bash

PROJECTFOLDER='project'
DB_ROOT_PASS='devel'
DB_USER='devel'
DB_NAME='drupal'

# Updating repository

sudo apt-get -y update

# Installing Apache
sudo apt-get -y install apache2

# Installing PHP and it's dependencies
sudo apt-get -y install php5 libapache2-mod-php5 php5-mcrypt

# Installing MySQL and it's dependencies, Also, setting up root password for MySQL as it will prompt to enter the password during installation

sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password ${DB_ROOT_PASS}'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password ${DB_ROOT_PASS}'
sudo apt-get -y install mysql-server-5.5 libapache2-mod-auth-mysql php5-mysql

# Creat database
if [ ! -f /var/log/databasesetup ];
then
    echo "CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}'" | mysql -uroot -p${DB_ROOT_PASS}
    echo "CREATE DATABASE ${DB_NAME}" | mysql -uroot -p${DB_ROOT_PASS}
    echo "GRANT ALL ON ${DB_NAME}.* TO '${DB_USER}'@'localhost'" | mysql -uroot -p${DB_ROOT_PASS}
    echo "flush privileges" | mysql -uroot -p${DB_ROOT_PASS}

    touch /var/log/databasesetup
fi

# setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/html/${PROJECTFOLDER}"
    <Directory "/var/www/html/${PROJECTFOLDER}">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

# enable mod_rewrite
sudo a2enmod rewrite

# restart apache
service apache2 restart
