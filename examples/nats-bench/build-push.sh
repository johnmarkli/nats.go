#!/bin/bash
make clean
make build-linux
cp ../../release/linux/nats-bench .
docker build --no-cache -t nats-bench:`git rev-parse --short HEAD` .
docker tag nats-bench:5a67486 registry.gitlab.com/uhn/uhn/nats-bench:test
docker push registry.gitlab.com/uhn/uhn/nats-bench:test
