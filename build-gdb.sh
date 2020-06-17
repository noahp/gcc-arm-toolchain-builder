#!/usr/bin/env bash

# Build just gdb. Args are:
# $1 - source archive in cwd, ex 'gcc-arm-none-eabi-9-2020-q2-update-src.tar.bz2'

# Error on any non-zero command, and print the commands as they're run
set -ex

# Make sure we have the docker utility
if ! command -v docker; then
    echo "🐋 Please install docker first 🐋"
    exit 1
fi

# Set the docker image name to default to repo basename
DOCKER_IMAGE_NAME=${DOCKER_IMAGE_NAME:-$(basename -s .git "$(git remote --verbose | awk 'NR==1 { print tolower($2) }')")}

# build the docker image
docker build -t "$DOCKER_IMAGE_NAME" -f Dockerfile .

# default python version is 3.7
PYTHON_VERSION=${PYTHON_VERSION:-python3.7}

# build gdb with the helper script. pass it current user id + group to chown
# after copying out result
docker run -v "$(pwd)":/data -t "$DOCKER_IMAGE_NAME" \
    bash -c "PYTHON_VERSION=$PYTHON_VERSION /data/build-in-container.sh $1 $(id -u):$(id -g)"
