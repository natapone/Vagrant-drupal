<?php

$databases['default']['default'] = array(
    'driver' => 'mysql',
    'database' => 'drupal',
    'username' => 'devel',
    'password' => 'devel',
    'host' => 'localhost',
    'prefix' => '',
);

$config_directories = array();

$settings['hash_salt'] = '';

$settings['update_free_access'] = TRUE;

$settings['container_yamls'][] = __DIR__ . '/services.yml';
