#!/bin/bash
# Set the context to desired namespace
kubectl config set-context --current --namespace=insurance

# Execute the export task by using the source pod where trading networks is deployed
kubectl exec deploy/tradingnetworks -- bash -c "cd /opt/softwareag/IntegrationServer/packages/WmTN/bin;./tnexport.sh -bin ExportedData -all;cat /opt/softwareag/IntegrationServer/ExportedData.zip" > ExportedData-$1.zip                   
