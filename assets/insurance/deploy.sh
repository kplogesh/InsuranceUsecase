echo "Building Assessments Image"
cd insurance-usecase-type-apigw-mgw/applications/
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

echo "Installing Istio - Service Mesh"
curl -L https://istio.io/downloadIstio | sh -
export PATH="$PATH:$PWD/istio-1.16.0/bin"
istioctl install --set profile=demo -y
kubectl create ns insurance
kubectl label namespace insurance istio-injection=enabled

echo "Install the applications - Insurance Usecase"
kubectl kustomize apply -k k8s-env-manifests/overlays/app/

echo "Install the Observability - Components"
kubectl kustomize apply -k k8s-env-manifests/overlays/olly/