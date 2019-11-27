#!/bin/bash
make clean
make build-linux
cp ../../release/linux/nats-sub .
docker build --no-cache -t nats-sub:`git rev-parse --short HEAD` .
docker tag nats-sub:5a67486 registry.gitlab.com/uhn/uhn/nats-sub:test
docker push registry.gitlab.com/uhn/uhn/nats-sub:test
