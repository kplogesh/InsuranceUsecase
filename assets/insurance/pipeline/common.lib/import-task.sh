#!/bin/bash
# Set the context to desired namespace
kubectl config set-context --current --namespace=insurance
sed -i "s/<TAG>/$1/" assets/insurance/insurance-usecase-type-apigw-extes/applications/tradingnetworks/dev/sourcecode/tn-assets/consolidated/TNExport.xml
# Create the configmap with the exported data from source trading networks
kubectl create configmap tn-data-load --from-file=ExportedData.zip --from-file=assets/insurance/insurance-usecase-type-apigw-extes/applications/tradingnetworks/dev/sourcecode/tn-assets/consolidated/TNExport.xml

# Modify the k8s job name with release iteration and apply the k8s job specifications 
cd assets/insurance/insurance-usecase-type-apigw-extes/applications/tradingnetworks/staging/manifests/job
sed -i "s/<TAG>/$1/" asset-import-job.yaml
kubectl apply -f ../tn-appconfig.yaml -f ../tn-env-script-cm.yaml -f .
sleep 5

# List the k8s jobs that has been created
kubectl get jobs | grep job-asset-import-tradingnetworks-r-$1

# Tail the logs of the job that has been created
kubectl logs -f job/job-asset-import-tradingnetworks-r-$1

# Delete the configmap containing the exported data from source trading networks
kubectl delete cm tn-data-load