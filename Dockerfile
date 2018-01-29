# Pull base image
FROM ubuntu

# Install Nginx
RUN \
  apt-get update && \
  apt-get install -y nginx && \
  apt-get install -y php-fpm php-mysql && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# Define working directory
WORKDIR /etc/nginx

#Copy nginx config to change port to 8080
COPY nginx_8080_php.conf /etc/nginx/sites-enabled/default

#Copy HTML source code
COPY ./htmlsrc /var/www/html

#Start nginx and PHP server
CMD service php7.0-fpm start && nginx

# Expose ports
EXPOSE 8080
