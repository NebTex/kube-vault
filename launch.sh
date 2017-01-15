#!/usr/bin/env bash

if kubectl get secrets --namespace vault | grep -q "vault-secrets"; then
    echo "Secrets already exists"
else
    # download sigil
    curl -fsSL https://github.com/gliderlabs/sigil/releases/download/v0.4.0/sigil_0.4.0_Linux_x86_64.tgz | tar -zxC /tmp

    /tmp/sigil -p -f vault-secrets.yml secret="$(/tmp/sigil -p -f config.json  AclToken=${AclToken:?} \
| base64 -w 0)" | kubectl  apply --validate --overwrite -f -
fi

kubectl apply -f vault-deployment.yml --validate --overwrite
kubectl apply -f vault-service.yml --validate --overwrite