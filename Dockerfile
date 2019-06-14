FROM nginx:alpine
LABEL maintainer="Samuel Bartag <samuel@samuelbartag.com.br>"


WORKDIR /var/www

RUN rm -f /etc/nginx/conf.d/*

RUN adduser -u 1000 -D -S -G www-data www-data

# Install packages
RUN apk --update add wget \
    curl \
    supervisor

COPY conf/nginx.conf /etc/nginx/
COPY conf/site.conf /etc/nginx/conf.d/site.conf
COPY conf/supervisord.conf /etc/


VOLUME ["/var/www", "/etc/nginx/conf.d", "/var/log/nginx"]

EXPOSE 80 443

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
