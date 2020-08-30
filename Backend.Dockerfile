FROM debian:buster

ARG WORK_DIR=/tmp/src/
WORKDIR ${WORK_DIR}
RUN apt update && apt install -y git apache2 php libapache2-mod-php php-mysql php-mbstring php-gd php-pdo php-xml php-cli php-curl php-http php-json

RUN git clone https://github.com/koseven/koseven.git
RUN git clone https://github.com/yurkovskiy/dtapi.git

RUN mkdir -p /var/www/dtapi/api
RUN cp -r ${WORK_DIR}koseven/system /var/www/dtapi/api/
RUN cp -r ${WORK_DIR}koseven/modules /var/www/dtapi/api/
RUN cp ${WORK_DIR}koseven/public/index.php /var/www/dtapi/api/
RUN cp -r ${WORK_DIR}dtapi/application /var/www/dtapi/api/
RUN cp -r ${WORK_DIR}dtapi/.htaccess /var/www/dtapi/api/
RUN mkdir /var/www/dtapi/api/application/cache /var/www/dtapi/api/application/logs
RUN chown -R www-data:www-data /var/www/dtapi
RUN chmod 733 /var/www/dtapi/api/application/cache
RUN chmod 722 /var/www/dtapi/api/application/logs

RUN sed -i "s|'PDO_MySQL'|'PDO'|g" /var/www/dtapi/api/application/config/database.php
RUN sed -i "/'dsn'/ s|mysql:host=localhost;dbname=dtapi2|mysql:host=172.17.0.2;dbname=dtapi|" /var/www/dtapi/api/application/config/database.php
RUN sed -i "/'password'/ s|'dtapi'|'password'|" /var/www/dtapi/api/application/config/database.php
RUN sed -i "/'base_url'/ s|'/'|'/api/'|" /var/www/dtapi/api/application/bootstrap.php

COPY ./dtapi.conf  /etc/apache2/sites-available/dtapi.conf

RUN a2ensite dtapi
RUN a2dissite 000-default
RUN a2enmod headers
RUN a2enmod rewrite

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
