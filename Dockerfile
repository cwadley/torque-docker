FROM php:7.3.4-apache
LABEL maintainer="clint@clintwadley.com"
RUN apt-get update \
	&& apt-get install -y git mysql-client netcat \
	&& docker-php-ext-install mysqli && docker-php-ext-enable mysqli \
	&& mkdir /var/torque \
	&& git clone https://github.com/cwadley/torque.git /var/torque \
	&& cp -r /var/torque/web/* /var/www/html \
	&& mv /var/www/html/creds-sample.php /var/www/html/creds.php \
	&& chown -R www-data:www-data /var/www/html \
	&& find /var/www/html -type d -exec chmod 755 {} + \
	&& find /var/www/html -type f -exec chmod 644 {} +

COPY ./copy_creds.sh ./create_db_tables.sh ./

ENTRYPOINT ["/bin/bash"]
CMD ["-c", "/var/www/html/copy_creds.sh /var/www/html/creds.php && ./create_db_tables.sh && docker-php-entrypoint apache2-foreground"]