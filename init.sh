#!/bin/bash

set -euf -o pipefail

cd ../3nodes-quorum
./raft-init.sh
./raft-start.sh
cd -

# Quorum must be running for this to succeed as it contains an integration test
cd ../erc20-rest-service
./gradlew clean build

mkdir -p ../3nodes-service/lib
cp build/libs/erc20-rest-service-0.1.0.jar ../3nodes-service/lib
cd ../3nodes-service
cp ../erc20-quorum-vm-example/service-start.sh .

for i in 1 2 3; do
  mkdir -p "service${i}"
  cp "../erc20-quorum-vm-example/config/node${i}.yml" "service${i}/application.yml"
done

cd -

./service-start.sh

