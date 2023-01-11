echo "This script will begin the uninstallation of insurance usecase

Components will be deleted on the host - $HOSTNAME

Please confirm to continue [Y|N]: "
read choice

if [[ "$choice" != "Y" ]]
then
       echo "You have chosen to discontinue. No further actions."
       exit 1
fi

echo "Uninstall the applications - Insurance Usecase"
kubectl delete -k ../k8s-env-manifests/overlays/type-apigw/

echo "Uninstall the Observability - Components"
kubectl delete -k ../k8s-env-manifests/overlays/olly/

echo "deleting local path provisioner"
kubectl delete -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.23/deploy/local-path-storage.yaml
