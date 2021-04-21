#!/bin/bash
echo "stop nginx" && docker stop nginx > /dev/null
echo "start nginx" && docker run -d \
    --rm \
    --name=nginx \
    -v  /srv/juneway/less4-docker/nginx-conf:/usr/local/nginx/conf \
    -p 80:80 \
    nginx:task4-v3

