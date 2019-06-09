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
$ tar -zxvf related_module.zip

$ cd ../themes/
$ git clone git@github.com:natapone/wbp_haha_theme.git
