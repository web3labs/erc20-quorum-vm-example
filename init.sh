#!/bin/bash

set -euf -o pipefail

cd ../3nodes
./raft-init.sh
./raft-start.sh

# Quorum must be running for this to succeed as it contains an integration test
cd ../erc20-rest-service
./gradlew clean build

for i in 1 2 3; do
  mkdir "../erc20-service${i}"
  cp build/libs/erc20-rest-service-0.1.0.jar "../erc20-service${i}"
  cp "../erc20-quorum-vm-example/config/node${i}.yml" "../erc20-service${i}"
done

./erc20-services-start.sh

