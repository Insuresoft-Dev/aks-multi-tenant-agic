#/bin/bash

# Variables
email="tpurl@insuresoft.com"
namespace="default"
clusterIssuer="letsencrypt-application-gateway"
template="cluster-issuer.yml"

# Check if the cluster issuer already exists
result=$(kubectl get clusterissuer -n $namespace -o jsonpath="{.items[?(@.metadata.name=='$clusterIssuer')].metadata.name}")

if [[ -n $result ]]; then
    echo "[$clusterIssuer] cluster issuer already exists"
    exit
else
    # Create the cluster issuer 
    echo "[$clusterIssuer] cluster issuer does not exist"
    echo "Creating [$clusterIssuer] cluster issuer..."
    # cat $template | yq -Y "(.spec.acme.email)|="\""$email"\" | kubectl apply -n $namespace -f -
    cat $template | sed "s|{{email}}|$email|g" | kubectl apply -n $namespace -f -
                

fi