FROM dockyard.armada.sh/microservice_php
MAINTAINER Cerebro <cerebro@ganymede.eu>

ENV FORCE_APT_UPDATE 1
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update -y
RUN apt-get install -y composer php5.6-xml autossh

# Install phpMyAdmin.
RUN mkdir -p /opt/src
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.8.2/phpMyAdmin-4.8.2-all-languages.tar.gz -O /opt/src/pma.tar.gz
RUN cd /opt/src && tar xf pma.tar.gz
RUN cd /opt/src/phpMyAdmin-4.8.2-all-languages && composer update --no-dev
RUN rm /opt/src/pma.tar.gz

# Configure phpMyAdmin.
RUN mkdir -p /opt/www && ln -s /opt/src/phpMyAdmin-4.8.2-all-languages /opt/www/www
RUN sed -ri 's/^session.gc_maxlifetime.*/session.gc_maxlifetime = 43200/g' /etc/php5/apache2/php.ini
RUN sed -ri 's/^post_max_size.*/post_max_size = 128M/g' /etc/php5/apache2/php.ini
RUN sed -ri 's/^upload_max_filesize.*/upload_max_filesize = 128M/g' /etc/php5/apache2/php.ini
RUN sed -i "s@define('CONFIG_DIR', '');@define('CONFIG_DIR', '/etc/phpmyadmin/');@" /opt/www/www/libraries/vendor_config.php
RUN sed -i "s@define('TEMP_DIR', './tmp/');@define('TEMP_DIR', '/tmp/');@" /opt/www/www/libraries/vendor_config.php
RUN mkdir -p /etc/phpmyadmin/conf.d/
COPY src/config.inc.php /etc/phpmyadmin/
COPY src/phpmyadmin_longer_session.php /etc/phpmyadmin/conf.d/

COPY ./supervisor/* /etc/supervisor/conf.d/
COPY . /opt/phpmyadmin
