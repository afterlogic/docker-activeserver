FROM alpine:3.16
LABEL Maintainer="Afterlogic Support <support@afterlogic.com>" \
      Description="Afterlogic ActiveServer image for Docker - using Nginx and PHP-FPM 8.1 on Alpine Linux"

RUN apk --no-cache add php81 \
	php81-cli \
	php81-fpm \
	php81-iconv \
	php81-mbstring \
	php81-imap \
	php81-curl \
	php81-pdo \
	php81-dom \
	php81-xsl \
	php81-xmlwriter \
	php81-simplexml \
	nginx supervisor curl tzdata

COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/fpm-pool.conf /etc/php81/php-fpm.d/www.conf
COPY config/php.ini /etc/php81/conf.d/custom.ini
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /var/www/html
RUN chown -R nobody.nobody /var/www/html && \
	chown -R nobody.nobody /run && \
	chown -R nobody.nobody /var/lib/nginx && \
	chown -R nobody.nobody /var/log/nginx

WORKDIR /var/www/html

RUN wget -P /tmp https://afterlogic.com/download/afterlogic-activeserver.zip
RUN unzip -qq /tmp/afterlogic-activeserver.zip -d /var/www/html
RUN mkdir -p /var/www/html/data/logs
RUN chown -R nobody.nobody /var/www/html
USER nobody
EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping
