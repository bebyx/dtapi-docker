FROM debian:buster

ARG WORK_DIR=/tmp/src/
WORKDIR ${WORK_DIR}
RUN apt update && apt install -y apache2 wget git curl sudo

RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
RUN apt install nodejs -y

RUN git clone https://github.com/yurkovskiy/IF-105.UI.dtapi.if.ua.io.git
RUN npm i npm@latest -g && npm i -g @angular/cli && npm i --prefix ./IF-105.UI.dtapi.if.ua.io

RUN sed -i "s|https://dtapi.if.ua/api/|http://localhost/api/|" ./IF-105.UI.dtapi.if.ua.io/src/environments/environment.ts && \
    sed -i "s|https://dtapi.if.ua/api/|http://localhost/api/|" ./IF-105.UI.dtapi.if.ua.io/src/environments/environment.prod.ts

RUN cd ./IF-105.UI.dtapi.if.ua.io/ && ng build --prod

RUN mkdir -p /var/www/dtapi
RUN cp -r ${WORK_DIR}IF-105.UI.dtapi.if.ua.io/dist/IF105/* /var/www/dtapi/
RUN wget "https://dtapi.if.ua/~yurkovskiy/IF-108/htaccess_example_fe" -O /var/www/dtapi/.htaccess
RUN chown -R www-data:www-data /var/www/dtapi

COPY ./dtapi.conf  /etc/apache2/sites-available/dtapi.conf
RUN a2ensite dtapi
RUN a2dissite 000-default
RUN a2enmod headers
RUN a2enmod rewrite

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
