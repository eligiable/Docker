#!/bin/bash
# Server Setup Script
# Installs and configures:
# - System updates
# - Nginx with PageSpeed module
# - Node.js environment (NVM, Node, Angular CLI)
# - PHP 7.2 and required dependencies
# - Git configuration

set -e # Exit immediately if any command fails

echo "Starting server setup..."

# System Update and Cleanup
echo "Updating system packages..."
apt update && apt -y upgrade && apt -y autoremove && \
apt autoclean && apt clean

# Install Base Packages
echo "Installing required packages..."
apt install -y sudo git python2.7 python3 nginx php7.2 php7.2-fpm nano

# Install PageSpeed Prerequisites
echo "Installing PageSpeed dependencies..."
apt install -y libssl-dev build-essential zlib1g-dev \
libpcre3-dev unzip wget uuid-dev curl

# Install Nginx with PageSpeed
echo "Installing Nginx with PageSpeed module..."
bash <(curl -f -L -sS https://ngxpagespeed.com/install) \
--nginx-version latest \
--prefix=/etc/nginx \
--sbin-path=/usr/sbin/nginx \
--modules-path=/usr/lib/nginx/modules \
--conf-path=/etc/nginx/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--pid-path=/var/run/nginx.pid \
--lock-path=/var/run/nginx.lock \
--http-client-body-temp-path=/var/cache/nginx/client_temp \
--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
--http-scgi-temp-path=/var/cache/nginx/scgi_temp \
--user=nginx \
--group=nginx \
--with-http_ssl_module \
--with-http_v2_module

# Configure PageSpeed Cache
echo "Configuring PageSpeed cache..."
useradd --no-create-home nginx && \
mkdir -p /var/cache/nginx/client_temp && \
mkdir /var/cache/ngx_pagespeed && \
chown nginx:nginx /var/cache/ngx_pagespeed && \
chown -R www-data:www-data /var/www/html && \
chmod -R 755 /var/www/html && \
sed -i 's|include /etc/nginx/modules-enabled/|#include /etc/nginx/modules-enabled/|' /etc/nginx/nginx.conf

# Install NVM and Node.js
echo "Setting up Node.js environment..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash && \
export NVM_DIR="$HOME/.nvm" && \
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
nvm install --lts && \
nvm install node && \
npm install -g @angular/cli --unsafe-perm=true --allow-root

# Configure Git
echo "Configuring Git..."
git config --global credential.helper store

echo "Server setup completed successfully!"