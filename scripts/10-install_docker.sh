#!/bin/bash

apt -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install apt-transport-https ca-certificates curl gnupg-agent software-properties-common openssl
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt -qqy update
apt -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install docker-ce docker-ce-cli containerd.io

docker network create -d bridge wikinet
docker volume create pgdata
docker create --name=db -e POSTGRES_DB=wiki -e POSTGRES_USER=wiki -e POSTGRES_PASSWORD_FILE=/run/secrets/wiki-db-pwd -v pgdata:/var/lib/postgresql/data --restart=unless-stopped -h db --network=wikinet postgres:11
docker create --name=wiki -e DB_TYPE=postgres -e DB_HOST=db -e DB_PORT=5432 -e DB_PASS_FILE=/run/secrets/wiki-db-pwd -e DB_USER=wiki -e DB_NAME=wiki -e TRUST_PROXY=true -e VIRTUAL_HOST=wiki.local --restart=unless-stopped -h wiki --network=wikinet -p 80:3000 requarks/wiki:dev
# docker create --name=nginx-proxy -p 80:80 -p 443:443 -e DEFAULT_HOST=wiki.local --network=wikinet -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy
docker create --name=watchtower --network=wikinet -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --cleanup --schedule="0 0 2 ? * SAT *" wiki
