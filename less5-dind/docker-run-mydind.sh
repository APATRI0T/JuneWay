#!/bin/bash
echo "stop and rm mydind" && docker rm -f mydind > /dev/null
echo "start mydind" && docker run -d \
    --name=mydind \
    --privileged \
    -v /srv/juneway/less5-dind/DIND:/DIND \
    -it \
    debian:10 \
    /bin/bash

echo "enter container:"
docker exec -it mydind bash