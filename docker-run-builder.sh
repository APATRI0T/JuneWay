#!/bin/bash
echo "stop builder" && docker rm builder -f > /dev/null
echo "start builder" && docker run \
    -it \
    --name=builder \
    -v  /srv/juneway/less4-docker/nginx-lua/:/NGINX \
    debian:mybuilder-v2 \
    /bin/bash


    # --rm \