#!/usr/bin/env bash

if kubectl get secrets --namespace vault | grep -q "vault-secrets"; then
    echo "Vault secrets already exists"
else
    sigil -p -f vault-secrets.yml secret="$(sigil -p -f config.json  acl_vault_token=${acl_vault_token:?} \
| base64 -w 0)" | kubectl  apply --validate --overwrite -f -
fi

if kubectl get secrets --namespace vault | grep -q "consul-secrets"; then
    echo "Consul secrets already exists"
else
    sigil -p -f consul-secrets.yml secret="$(sigil -p -f consul-config.json  acl_agent_token=${acl_agent_token:?} \
| base64 -w 0)" | kubectl  apply --validate --overwrite -f -
fi

kubectl apply -f vault-deployment.yml --validate --overwrite
kubectl apply -f vault-service.yml --validate --overwrite