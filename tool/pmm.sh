#!/bin/bash
docker rm -f pmm-data pmm-server

docker create -v /opt/prometheus/data \
    -v /opt/consul-data \
    -v /var/lib/mysql \
    -v /var/lib/grafana \
    --name pmm-data \
    percona/pmm-server /bin/true

docker run -d --restart=always \
    --network=others --ip=111.222.222.222 -p 9600:80 \
    --volumes-from pmm-data \
    --name pmm-server \
    percona/pmm-server

