#!/bin/bash

set -euf -o pipefail

add-apt-repository ppa:webupd8team/java -y
apt-get update

echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get install -y oracle-java8-installer

git clone https://github.com/blk-io/erc20-rest-service.git ../erc20-rest-service

chown -R ubuntu:ubuntu /home/ubuntu/

