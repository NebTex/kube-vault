#!/usr/bin/env bash

kubectl apply -f vault-namespace.yml --validate --overwrite
kubectl apply -f vault-deployment.yml --validate --overwrite
kubectl apply -f vault-service.yml --validate --overwrite