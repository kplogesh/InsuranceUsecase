echo "This script will begin the uninstallation of insurance usecase

Components will be deleted on the host - $HOSTNAME

Please confirm to continue [Y|N]: "
read choice

if [[ "$choice" != "Y" ]]
then
       echo "You have chosen to discontinue. No further actions."
       exit 1
fi
cd insurance-usecase-type-apigw-mgw/applications/

echo "deleting local path provisioner"

echo "Uninstall Istio - Service Mesh"
cd ../../
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.16.1/bin
./istioctl uninstall --purge

echo "Install the applications - Insurance Usecase"
kubectl delete -k k8s-env-manifests/overlays/app/

echo "Install the Observability - Components"
kubectl delete -k k8s-env-manifests/overlays/olly/

kubectl delete ns insurance monitoring