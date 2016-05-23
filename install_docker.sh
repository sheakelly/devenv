#!/usr/bin/env bash
# install docker
curl -sSL https://get.docker.com/gpg | sudo apt-key add -
curl -sSL https://get.docker.com/ | sh
# install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.6.0/docker-compose-`uname -s`-`uname -m` > /tmp/docker-compose
sudo cp /tmp/docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker skelly
