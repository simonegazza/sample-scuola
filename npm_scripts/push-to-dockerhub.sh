#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    TAG="latest"
else
    TAG=$1
fi

echo "Building image"
docker build -t scuolaonlineservice/sample-scuola:$TAG .

echo "Login to dockerhub required"
docker login

echo "Pushing to dockerhub"
docker push scuolaonlineservice/sample-scuola:$TAG
