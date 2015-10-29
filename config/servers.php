<?php

$hint = 'Configure servers in servers.php config file';

$i;
$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['verbose'] = $hint;

++$i;
$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['verbose'] = 'Server 1.';

++$i;
$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['verbose'] = 'Server 2.';
