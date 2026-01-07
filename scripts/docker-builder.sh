#!/bin/bash

docker buildx create --name homelab --driver remote tcp://10.0.0.70:3000
docker buildx create --name homelab --driver remote tcp://10.0.0.70:3001 --append
