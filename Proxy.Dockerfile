FROM nginx

COPY ./lb.conf /etc/nginx/conf.d/lb.conf
RUN rm /etc/nginx/conf.d/default.conf /usr/share/nginx/html/*

EXPOSE 80
