<?php

# See http://docs.phpmyadmin.net/en/latest/config.html#server-connection-settings for advanced options.

$hint = 'See instructions in README to configure list of servers.';

$i = 1;
$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['verbose'] = $hint;

++$i;
$cfg['Servers'][$i]['host'] = '192.168.0.1';
$cfg['Servers'][$i]['verbose'] = 'Server 1.';
$cfg['Servers'][$i]['port'] = '3307';

++$i;
$cfg['Servers'][$i]['host'] = '192.168.0.2';
$cfg['Servers'][$i]['verbose'] = 'Server 2.';
$cfg['Servers'][$i]['port'] = '3308';
