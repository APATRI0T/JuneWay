#!/bin/bash
echo "stop dind" && docker rm -f dind > /dev/null
echo "start dind" && docker run -d \
    --name=dind \
    --privileged \
    -v /srv/juneway/less5-dind/DIND:/DIND \
    docker:dind \
    # sh
    # -it \
    # --rm \
echo "enter container"
docker exec -it dind sh