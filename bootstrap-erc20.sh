#!/bin/bash

add-apt-repository ppa:webupd8team/java
apt-get update

echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get install -y apt-get install oracle-java8-installer

git clone https://github.com/blk-io/erc20-rest-service.git

cd erc20-rest-service
./gradlew clean build

cd -

