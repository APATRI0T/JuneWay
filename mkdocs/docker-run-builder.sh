#!/bin/bash
echo "stop mkdocs" && docker rm mkdocs -f > /dev/null
echo "start mkdocs" && docker run \
    -it \
    --name=mkdocs \
    -p 80:80 \
    -v ${PWD}/docs:/docs \
    squidfunk/mkdocs-material
    # /bin/bash
    # --rm \