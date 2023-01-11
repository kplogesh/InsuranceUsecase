echo "This script will begin the setup of insurance usecase using Software AG product stack and Observability components

Components will be created on the host - $HOSTNAME

Pre-requisites should be configured as mentioned below

Docker Credentials and Software AG's Container repo Credentials should be created as follows...

kubectl create secret docker-registry regcred --docker-username=<username> --docker-password=<password> --docker-email=<email id>

kubectl create secret docker-registry sagregcred --docker-server=sagcr.azurecr.io --docker-username=<username> --docker-password=<password> --docker-email=<email>

Please confirm to continue [Y|N]: "
read choice

if [[ "$choice" != "Y" ]]
then
       echo "You have chosen to discontinue. No further actions."
       exit 1
fi

echo "Building Assessments Image"
cd applications/
docker build -f assessments/Dockerfile -t fitness-assessments:v1.0 .

echo "Building Challenges Image"
docker build -f challenges/Dockerfile -t fitness-challenges:v1.0 .

echo "Building Memberships Image"
docker build -f memberships/Dockerfile -t fitness-memberships:v1.0 .

echo "Building Points Image"
docker build -f points/Dockerfile -t fitness-points:v1.0 .

echo "Building Rewards Image"
docker build -f rewards/Dockerfile -t fitness-rewards:v1.0 .

echo "Installing local path provisioner for volumes"
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.23/deploy/local-path-storage.yaml

kubectl create ns insurance

cd ../../
echo "Install the applications - Insurance Usecase"
kubectl apply -k k8s-env-manifests/overlays/type-apigw/

echo "Install the Observability - Components"
kubectl apply -k k8s-env-manifests/overlays/olly/
