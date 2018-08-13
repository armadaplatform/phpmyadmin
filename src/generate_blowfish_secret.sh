#!/usr/bin/env bash

echo "<?php \$cfg['blowfish_secret'] = '$(cat /dev/urandom | tr -cd '[:alnum:]' | head -c 32)';" > /etc/phpmyadmin/conf.d/blowfish_secret.php
