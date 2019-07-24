#!/bin/bash
set -e

if [ -d ./k8s ]
then
    rm -f k8s/*
else
    mkdir ./k8s
fi
docker-compose config | kompose convert -f - -o ./k8s 

echo "You can now deploy KillrVideo to Kubernetes with 'kubectl apply -f ./k8s'"
