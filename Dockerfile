FROM php:8.2-apache

# cURL is required for every checker in this repo
RUN docker-php-ext-install curl

WORKDIR /var/www/html

COPY . /var/www/html/

# Render injects $PORT at runtime (default 10000)
ENV PORT=10000

# Startup script rewrites Apache's listen port to $PORT, then starts Apache
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 10000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
