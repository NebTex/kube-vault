#!/usr/bin/env bash

kubectl delete -f vault-namespace.yml
kubectl delete -f vault-deployment.yml
kubectl delete -f vault-service.yml