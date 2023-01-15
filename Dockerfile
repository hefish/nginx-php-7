FROM ubuntu:20.04

LABEL TITLE="nginx+php7.4"

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt update && apt upgrade -y && \
    DEBIAN_FRONTEND=noninteractive TZ=Asia/Shanghai apt-get -y install tzdata php-cli php-fpm php-gd php-mysql php-imagick php-curl supervisor nginx && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 

ADD config/nginx-php.conf /etc/supervisor/conf.d/nginx-php.conf
ADD config/nginx.conf /etc/nginx/nginx.conf
ADD config/php.ini /etc/php/7.4/fpm/php.ini
ADD config/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# VOLUME /etc/nginx/nginx.conf 
# VOLUME /etc/nginx/conf.d
# VOLUME /etc/php/7.4/fpm/php.ini
# VOLUME /etc/php/7.4/fpm/pool.d/www.conf
VOLUME /var/log/nginx
VOLUME /var/log/php
VOLUME /var/www/html

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/nginx-php.conf"]

EXPOSE 80
EXPOSE 443


