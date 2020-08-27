FROM alpine:latest AS K7_BACKEND

WORKDIR /tmp/src/
RUN apk update
RUN apk add git apache2

EXPOSE 80

# ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
