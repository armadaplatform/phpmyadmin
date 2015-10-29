<?php
require_once '/opt/microservice_php/src/hermes.php';

$servers_file_path = Hermes::get_config_file_path('servers.php');
if (!empty($servers_file_path)) {
    system('cp '.$servers_file_path.' /etc/phpmyadmin/conf.d/');
}
