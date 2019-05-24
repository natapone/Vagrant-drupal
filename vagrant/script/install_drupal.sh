PROJECT_PATH='/var/www/html/project'


mkdir -p ${PROJECT_PATH}/sites/default/files
# only for fresh install
sudo chmod 777 -R ${PROJECT_PATH}/sites/default/files
sudo chmod 777 ${PROJECT_PATH}/sites/default/settings.php

# For Drupal 8
# sudo apt-get -y install nginx
