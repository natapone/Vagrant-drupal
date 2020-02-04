PROJECT_PATH='/var/www/html/project'
DRUPAL_VER='drupal-8.8.2'

DB_ROOT_PASS='devel'
DB_USER='devel'
DB_NAME='drupal'

mkdir -p ${PROJECT_PATH}/sites/default/files

cd /var/tmp
wget https://ftp.drupal.org/files/projects/${DRUPAL_VER}.tar.gz
tar -zxvf ${DRUPAL_VER}.tar.gz
cp -rf ${DRUPAL_VER}/* ${PROJECT_PATH}
cd ${PROJECT_PATH}

# Copy settings
DRUPAL_SETTINGS=$(cat <<EOF
<?php

\$databases['default']['default'] = array(
    'driver' => 'mysql',
    'database' => '${DB_NAME}',
    'username' => '${DB_USER}',
    'password' => '${DB_ROOT_PASS}',
    'host' => 'localhost',
    'prefix' => '',
);

\$config['system.logging']['error_level'] = 'verbose';
EOF
)

echo "${DRUPAL_SETTINGS}" > ${PROJECT_PATH}/sites/default/settings.php


# only for fresh install
# sudo chmod 755 -R ${PROJECT_PATH}
sudo chmod 777 -R ${PROJECT_PATH}/sites/default/files
sudo chmod 777 ${PROJECT_PATH}/sites/default/settings.php

# For Drupal 8
# sudo apt-get -y install nginx
