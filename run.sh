#!/bin/bash

NET=dt_net
SUB_NET=172.18.0.

read -s -p 'Enter Jenkins password: ' psw

docker run --net $NET --ip ${SUB_NET}2 --name db -e MYSQL_ALLOW_EMPTY_PASSWORD=true \
                     -e MYSQL_DATABASE=dtapi -e MYSQL_USER=dtapi \
                     -e MYSQL_PASSWORD=password -d mariadb \
                     --default-authentication-plugin=mysql_native_password
wget -q https://dtapi.if.ua/~yurkovskiy/dtapi_full.sql
wget -q https://dtapi.if.ua/~yurkovskiy/IF-108/sessions.sql
sleep 5
docker exec -i db sh -c 'exec mysql -uroot dtapi' < ./dtapi_full.sql
docker exec -i db sh -c 'exec mysql -uroot dtapi' < ./sessions.sql
docker restart db

docker build -t be -f Backend.Dockerfile .
docker run --net $NET --ip ${SUB_NET}3 --name=be -d -p 8000:80 be

wget http://localhost:8080/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s "http://localhost:8080" -auth $1:$psw build dtapi_js

docker build -t proxy -f Proxy.Dockerfile .
docker run --net $NET --ip ${SUB_NET}5 --name=proxy -d -p 80:80 proxy

rm dtapi_full.sql sessions.sql jenkins-cli.jar
