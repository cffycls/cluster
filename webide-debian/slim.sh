#!/bin/bash

docker
# https://downloads.dockerslim.com/releases/1.34.0/dist_mac.zip
# docker-slim b --http-probe=false node-java-python-for-one
docker-slim build  --http-probe=false node-java-python-for-one

# /usr/local/bin/sshpass -p 123456 /usr/bin/rsync -aurP /Users/wyq/Documents/workdir/my-github/cluster/webide-debian edz@edzdeiMac-3.local.:/Users/edz/workdir/webide-debian
