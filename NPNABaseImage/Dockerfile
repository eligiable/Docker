FROM ccore_base

MAINTAINER Abdul Haseeb Shafqat "eligiable@gmail.com"

SHELL ["/bin/bash", "-c"]

ENV PATH /root/.nvm/versions/node/v15.3.0/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash && \
	export NVM_DIR="$HOME/.nvm" && \
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
	apt install -y python-minimal && \
	cd /var/www/ && \
	git clone -b CCore_ang7 https://{GITURL}/{REPO}.git && \
	cd /var/www/{REPO}/ && \
	npm install --unsafe-perm=true --allow-root && \
	nvm install 14.15.0 && \
	nvm use 14.15.0 && \
	npm install -g @angular/cli@7.3.10 --unsafe-perm=true --allow-root && \
	ng build
CMD ["/bin/bash"]
