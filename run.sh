#!/bin/sh

docker run --name db -e MYSQL_ALLOW_EMPTY_PASSWORD=true MYSQL_DATABASE=dtapi MYSQL_USER=dtapi MYSQL_PASSWORD=password -d mariadb
wget -q https://dtapi.if.ua/~yurkovskiy/dtapi_full.sql
wget -q https://dtapi.if.ua/~yurkovskiy/IF-108/sessions.sql
docker exec -i db sh -c 'exec mysql -uroot dtapi' < ./dtapi_full.sql
docker exec -i db sh -c 'exec mysql -uroot dtapi' < ./sessions.sql
docker restart db
rm dtapi_full.sql sessions.sql


docker build -t be -f Backend.Dockerfile .
docker run --name=be -d -p 8000:80 be /usr/sbin/httpd -D FOREGROUND
