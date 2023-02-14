#!/bin/bash
kubectl config set-context --current --namespace=insurance
kubectl create configmap tn-data-load --from-file=ExportedData-$1.bin
cd assets/insurance/insurance-usecase-type-apigw-extes/applications/tradingnetworks/staging/manifests/job
sed -i "s/<TAG>/$1/" asset-import-job.yaml
sed -i "s/<TAG>/$1/" import-script-cm.yaml
kubectl apply -f ../tn-appconfig.yaml -f ../tn-env-script-cm.yaml -f .
sleep 5
kubectl get po 
kubectl logs -f job/job-asset-import-tradingnetworks-r-$1
kubectl delete cm tn-data-load