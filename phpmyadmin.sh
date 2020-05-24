#!/bin/bash

docker rm -f pma
docker run -d --name pma \
    --restart=always \
    --network=mybridge --ip=172.1.112.11 \
    -e PMA_HOST=172.1.11.11 -p 10080:80 \
    phpmyadmin/phpmyadmin

