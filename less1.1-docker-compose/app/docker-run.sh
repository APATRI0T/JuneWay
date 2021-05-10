#!/bin/bash
echo "stop django" && docker rm django -f > /dev/null
echo "start django" && docker run \
    -it \
    --name=django \
    -p 8000:8000 \
    django:v1 \
    # /bin/sh


    # -v  /srv/juneway/less4-docker/nginx-lua/:/NGINX \
    # --rm \