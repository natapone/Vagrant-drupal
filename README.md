# Vagrant-drupal
Simple vagrant box for Drupal installation

# Setting up latest Drupal
1. Extract latest Drupal
2. Copy all files to project folder
3. Update project/sites/default/settings.php before installation

# Getting start
$ vagrant up
http://localhost:3000/core/install.php

# Clone module
$ cd ../project/modules/
$ git clone git@github.com:natapone/wbp_haha_module.git

# Copy prerequisite modules on server
$ cp -rf wbp_haha_module/export/related_module.zip .
$ unzip related_module.zip
<!-- $ tar -zxvf related_module.zip -->

$ cd ../themes/
$ git clone git@github.com:natapone/wbp_haha_theme.git

# Install theme -> Install and set as default
http://localhost:3000/admin/appearance
- Bootstrap

# Enable modules - One module at the time!!! It might crash
http://localhost:3000/admin/modules
- Ha Ha Module
- Haha related modules config

# Set YouTube import keywords
http://localhost:3000/admin/config/haha
myanmar funny video, myanmar tik tok funny, myanmar joke, funny dog, funny cat

# Test create content: Import, update, publish to node
http://localhost:3000/haha/init
http://localhost:3000/haha/update
http://localhost:3000/haha/publish
http://localhost:3000/nonstop

# Manual config
- After everything pass

# Blocks
http://localhost:3000/admin/structure/block
- Content:
  - Blocks sorted properly
  - Latest shows only node/*
- Secondary: disable or remove
- Footer: disable or remove

# Front page
http://localhost:3000/admin/config/system/site-information
Default front page: /nonstop

#-----------------PRE PRODUCTION----------------------#

# Production only!!!
Generating a new SSH key and adding it to the ssh-agent
https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

$ ssh-keygen -t rsa -b 4096 -C "natapone@gmail.com"
$ vi ~/.ssh/id_rsa.pub
Copy key and pass to Github
https://github.com/settings/keys

$ cd ~
$ git clone git@github.com:natapone/Vagrant-drupal.git
$ cd /root/Vagrant-drupal/vagrant/script

# Change DB config:
- MySQL password
- Drupal version

$ vi 2_install_lamp.sh
$ vi 3_install_drupal

# Install scripts
$ sudo bash 1_bootstrap.sh
$ sudo bash 2_install_lamp.sh
$ sudo bash 3_install_drupal.sh

Install Drupal
http://128.199.246.222/

Disable public access
$ sudo chmod 755 -R /var/www/html/project/sites/default/
$ sudo chmod 644 /var/www/html/project/sites/default/settings.php

Continue install theme and modules as normal!!!

#-----------------POST PRODUCTION----------------------#

# GA Tracking ID
http://128.199.246.222/admin/config/system/google-analytics
UA-141691818-1

# Check database
$ mysql -u devel -p -D drupal
mysql> select count(h_id) from haha_content;

# Schedule cron job on host
$ crontab -e
15 */4 * * * curl -I "http://localhost/haha/update" > /var/www/html/project/cron_haha_update.log
0 * * * * curl -I "http://localhost/haha/publish" > /var/www/html/project/cron_haha_publish.log
$ crontab -l
