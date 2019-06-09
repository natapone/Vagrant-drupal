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

# Install theme
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
