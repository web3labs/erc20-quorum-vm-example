#!/bin/bash

set -euf -o pipefail

for i in 1 2 3; do
  cd "cs${i}"
  nohup java -jar ../lib/erc20-rest-service-0.1.0.jar &
  cd -
done

