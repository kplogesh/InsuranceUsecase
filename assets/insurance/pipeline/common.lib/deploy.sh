#!/bin/bash
kubectl config set-context --current --namespace=insurance
cd assets/insurance/insurance-usecase-type-apigw-extes/applications/tradingnetworks/staging/manifests
sed -i "s/<TAG>/$1/" tn-deployment.yaml
kubectl apply -f .