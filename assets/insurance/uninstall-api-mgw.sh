echo "This script will begin the uninstallation of insurance usecase

Components will be deleted on the host - $HOSTNAME

Please confirm to continue [Y|N]: "
read choice

if [[ "$choice" != "Y" ]]
then
       echo "You have chosen to discontinue. No further actions."
       exit 1
fi

echo "Uninstall Istio - Service Mesh"
cd istio-1.16.1/bin
./istioctl uninstall --purge -y

kubectl delete ns istio-system

echo "Uninstall the applications - Insurance Usecase"
kubectl delete -k k8s-env-manifests/overlays/app/

echo "Uninstall the Observability - Components"
kubectl delete -k k8s-env-manifests/overlays/olly/

kubectl delete ns insurance monitoring

echo "deleting local path provisioner"
