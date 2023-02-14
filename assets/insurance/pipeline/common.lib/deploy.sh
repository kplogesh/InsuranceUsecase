#!/bin/bash
# Set the context to desired namespace
kubectl config set-context --current --namespace=insurance

# Deploy the target manifests to create the runtimes/pods
cd assets/insurance/insurance-usecase-type-apigw-extes/applications/tradingnetworks/staging/manifests
sed -i "s/<TAG>/$1/" tn-deployment.yaml
kubectl apply -f .