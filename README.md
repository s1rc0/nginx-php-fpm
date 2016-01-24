## NGINX/PHP-FPM Dockerfile
Docker container with Nginx/PHP-FPM stack based on Centos7

This repository contains **Dockerfile** of [Nginx](http://nginx.org/) and [PHP-FPM](http://php.net/manual/en/install.fpm.php) for [Docker](https://www.docker.com/)'s [automated build](https://hub.docker.com/r/s1rc0/nginx-php-fpm/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [centos:7.2.1511](https://hub.docker.com/_/centos/)


### Usage

    docker run -d -p 80:80 docker pull s1rc0/nginx-php-fpm

#### Attach persistent/shared directories

    docker run -d -p 80:80 -v <html-dir>:/usr/share/nginx/html s1rc0/nginx-php-fpm

After few seconds, open `http://<host>` to see the welcome page.
