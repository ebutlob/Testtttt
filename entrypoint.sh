#!/usr/bin/env bash
set -e

# Render sets $PORT (default 10000). Apache must listen on it.
PORT="${PORT:-10000}"

# Rewrite ports.conf and the default vhost from :80 to :$PORT
sed -i "s/^Listen 80$/Listen ${PORT}/" /etc/apache2/ports.conf
sed -i "s/<VirtualHost \*:80>/<VirtualHost *:${PORT}>/" /etc/apache2/sites-available/000-default.conf

# Apache logs to stdout/stderr so Render captures them
ln -sf /proc/self/fd/1 /var/log/apache2/access.log
ln -sf /proc/self/fd/2 /var/log/apache2/error.log

exec apache2-foreground
