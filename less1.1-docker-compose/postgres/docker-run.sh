#!/bin/bash
echo "stop postgres" && docker rm postgres -f > /dev/null
echo "start postgres" && docker run \
    -it \
    --name=db \
    postgres \
    # /bin/sh


    # -v  /srv/juneway/less4-docker/postgres-lua/:/postgres \
    # --rm \