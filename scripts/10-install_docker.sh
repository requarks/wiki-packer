#!/bin/bash

apt -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install apt-transport-https ca-certificates curl gnupg-agent software-properties-common openssl
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt -qqy update
apt -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install docker-ce docker-ce-cli containerd.io
