#!/bin/bash
#update ubuntu
apt update && apt -y upgrade && apt -y autoremove && apt autoclean && apt clean && \

#install required packages
apt install -y sudo git python2.7 python3 nginx php7.2 php7.2-fpm nano && \

#install prerequisite for pagespeed
apt install -y libssl-dev && apt -y install curl && \
apt install -y build-essential zlib1g-dev libpcre3-dev unzip wget uuid-dev && \

#install nginx-pagespeed
bash <(curl -f -L -sS https://ngxpagespeed.com/install) --nginx-version latest

#didn't found a way to supply below arguments, so need to provide them manually
--prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-http_ssl_module --with-http_v2_module

#setup pagespeed cache
useradd --no-create-home nginx && mkdir -p /var/cache/nginx/client_temp && mkdir /var/cache/ngx_pagespeed && \
chown nginx:nginx /var/cache/ngx_pagespeed && chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html && \
sed -i 's|include /etc/nginx/modules-enabled/|#include /etc/nginx/modules-enabled/|' /etc/nginx/nginx.conf && \
service start nginx

#install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash && \
export NVM_DIR="$HOME/.nvm" && \
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \

#install node
nvm install node && nvm install --lts && \

#install ng
npm install -g @angular/cli --unsafe-perm=true --allow-root

#setup git credentials
git config --global credential.helper store
