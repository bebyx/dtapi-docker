FROM node:buster AS builder

ARG WORK_DIR=/tmp/src/
WORKDIR ${WORK_DIR}
COPY ./htaccess_example_fe /tmp/src/.htaccess
RUN apt update && apt install -y git sudo

RUN git clone https://github.com/yurkovskiy/IF-105.UI.dtapi.if.ua.io.git
RUN npm i -g @angular/cli && npm i --prefix ./IF-105.UI.dtapi.if.ua.io

RUN sed -i "s|https://dtapi.if.ua/api/|http://bebyx.ssh.if.ua/api/|" ./IF-105.UI.dtapi.if.ua.io/src/environments/environment.ts && \
    sed -i "s|https://dtapi.if.ua/api/|http://bebyx.ssh.if.ua/api/|" ./IF-105.UI.dtapi.if.ua.io/src/environments/environment.prod.ts

RUN cd ./IF-105.UI.dtapi.if.ua.io/ && ng build --prod

RUN mkdir -p /var/www/dtapi
RUN cp -r ${WORK_DIR}IF-105.UI.dtapi.if.ua.io/dist/IF105/* /var/www/dtapi/ && \
    cp ${WORK_DIR}.htaccess /var/www/dtapi/.htaccess
RUN chown -R www-data:www-data /var/www/dtapi

FROM debian:buster-slim

RUN apt update && apt install apache2 -y
COPY --from=builder --chown="www-data:www-data" /var/www/dtapi /var/www/dtapi
COPY ./dtapi.conf /etc/apache2/sites-available/dtapi.conf
RUN a2ensite dtapi && a2dissite 000-default && a2enmod headers && a2enmod rewrite

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
