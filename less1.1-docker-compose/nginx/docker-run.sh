#!/bin/bash
echo "stop nginx" && docker rm nginx -f > /dev/null
echo "start nginx" && docker run \
    -it \
    --name=nginx \
    nginx:serg-v1 \
    /bin/sh


    # -v  /srv/juneway/less4-docker/nginx-lua/:/NGINX \
    # --rm \