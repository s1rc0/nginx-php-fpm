FROM centos:7.2.1511
MAINTAINER Sergey Postument <sergey.postument@gmail.com>

RUN yum update -y
RUN yum install --nogpgcheck http://rpms.famillecollet.com/enterprise/remi-release-7.rpm -y
ADD docker/nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum --enablerepo=remi,remi-php56 install -y supervisor \
	nginx \
	php-fpm \
	php-common php-opcache \
	php-pecl-apcu \
	php-cli \
	php-pear \
	php-pdo \
	php-mysqlnd \
	php-pgsql \
	php-pecl-mongo \
	php-pecl-sqlite \
	php-pecl-memcache \
	php-pecl-memcached \
	php-gd \
	php-mbstring \
	php-mcrypt \
	php-xml \
	php-soap

# Configure PHP-FPM
RUN chown -R nginx:nginx /var/lib/php/
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php.ini && \
sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php.ini && \
sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" /etc/php.ini && \
sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php-fpm.conf
RUN sed -i -e "s/;listen.mode = 0660/listen.mode = 0777/g" /etc/php-fpm.d/www.conf

# Configure NGINX
RUN rm -f /etc/nginx/conf.d/default.conf
ADD docker/nginx/nginx.conf /etc/nginx/nginx.conf
ADD docker/nginx/site.conf /etc/nginx/conf.d/site.conf
ADD docker/php-fpm/www.conf /etc/php-fpm.d/www.conf
ADD . /usr/share/nginx/html

# Supervisor Config
ADD docker/supervisord.conf /etc/supervisord.conf

COPY docker/docker-entrypoint.sh /
RUN chmod 777 /docker-entrypoint.sh

# Setup Volume
VOLUME ["/usr/share/nginx/html"]

# Expose Ports
EXPOSE 80 443

CMD ["/docker-entrypoint.sh"]
