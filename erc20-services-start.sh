#!/bin/bash

set -euf -o pipefail

for i in 1 2 3; do
  cd "../erc20-service${i}"
  nohup java -jar erc20-rest-service-0.1.0.jar &
  cd -
done

