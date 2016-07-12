FROM microservice_php
MAINTAINER Cerebro <cerebro@ganymede.eu>

ENV PHPMYADMIN_APT_GET_UPDATE_DATE 2015-10-29
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:nijel/phpmyadmin
RUN apt-get update -y

# Install phpMyAdmin.
RUN echo "phpmyadmin phpmyadmin/internal/skip-preseed boolean true" | debconf-set-selections
RUN echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect" | debconf-set-selections
RUN echo "phpmyadmin phpmyadmin/dbconfig-install boolean false" | debconf-set-selections
RUN apt-get install -y phpmyadmin

# Configure phpMyAdmin.
RUN ln -s /etc/phpmyadmin/apache.conf /etc/apache2/sites-enabled/phpmyadmin.conf
RUN mkdir -p /opt/www && ln -s /usr/share/phpmyadmin /opt/www/www
RUN sed -ri 's/^session.gc_maxlifetime.*/session.gc_maxlifetime = 43200/g' /etc/php5/apache2/php.ini
RUN sed -ri 's/^post_max_size.*/post_max_size = 128M/g' /etc/php5/apache2/php.ini
RUN sed -ri 's/^upload_max_filesize.*/upload_max_filesize = 128M/g' /etc/php5/apache2/php.ini
ADD phpmyadmin_longer_session.php /etc/phpmyadmin/conf.d/

ADD ./supervisor/* /etc/supervisor/conf.d/
ADD . /opt/phpmyadmin

ENV CONFIG_DIR config
