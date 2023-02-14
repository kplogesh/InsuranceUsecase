#!/bin/bash
kubectl config set-context --current --namespace=insurance
kubectl exec deploy/tradingnetworks -- bash -c "cd /opt/softwareag/IntegrationServer/packages/WmTN/bin;./tnexport.sh -bin ExportedData -all;cat /opt/softwareag/IntegrationServer/ExportedData.zip" > ExportedData-$1.zip                   
