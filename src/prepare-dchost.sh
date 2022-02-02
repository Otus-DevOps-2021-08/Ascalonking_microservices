#! /bin/bash
eval $(docker-machine env docker-host)
docker pull mongo:latest
docker build -t krotpk/post:1.0 ./post-py
docker build -t krotpk/comment:1.0 ./comment
docker build -t krotpk/ui:1.0 ./ui
docker network create reddit
docker run -d --network=reddit --network-alias=base_pst --network-alias=msg_data mongo:latest
docker run -d --network=reddit --network-alias=sendpost krotpk/post:1.0
docker run -d --network=reddit --network-alias=msg_data krotpk/comment:1.0
docker run -d --network=reddit -p 9292:9292 krotpk/ui:1.0

open -a "Google Chrome" http://51.250.6.217:9292
