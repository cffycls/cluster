#!bin/bash
docker stop mc1
docker rm mc1

docker run --name mc1 -p 11211:11211 -d memcached memcached -m 64
