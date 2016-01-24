#!/bin/bash

procs=$(cat /proc/cpuinfo |grep processor | wc -l)
sed -i -e "s/worker_processes 5/worker_processes $procs/" /etc/nginx/nginx.conf

# Again set the right permissions (needed when mounting from a volume)
chown -Rf nginx.nginx /usr/share/nginx/html

# Start supervisord and services
/usr/bin/supervisord -n -c /etc/supervisord.conf
