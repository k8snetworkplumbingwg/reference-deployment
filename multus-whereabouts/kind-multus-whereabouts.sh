#!/usr/bin/env bash
set -e

if [ $# -eq 0 ]
  then
    echo ""
    echo "Error: Number of nodes not supplied, please add a number > 0"
    echo "Example: for 2 nodes, run: ./kind-multus-whereabouts.sh 2"
    echo ""
    exit
fi

FILE="cluster-config.yml"

# dynamically create cluster config based on user input
tee "$FILE" > /dev/null <<'EOF'
kind: Cluster 
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
EOF

if [ $1 -gt 1 ]
then
    append_num=$(($1-1))
    for (( i=1; i <= $append_num; i++ ))
    do
        tee -a "$FILE" > /dev/null <<'EOF'
  - role: worker
EOF
    done
elif [ $1 -lt 1 ]
then
    echo ""
    echo "Error: Number of nodes should be > 0"
    echo ""
    exit
fi

tee -a "$FILE" > /dev/null <<'EOF'
# Note: uncomment if you install cni plugin by yourself
#networking:
#  disableDefaultCNI: true
EOF

# start the KIND cluster
kind create cluster --config cluster-config.yml --name test

# install multus
kubectl create -f multus-daemonset.yml
kubectl config set-context --current --namespace=kube-system

# install whereabouts
kubectl apply \
    -f whereabouts-yml/daemonset-install.yml \
    -f whereabouts-yml/whereabouts.cni.cncf.io_ippools.yml \
    -f whereabouts-yml/whereabouts.cni.cncf.io_overlappingrangeipreservations.yml \
    -f whereabouts-yml/ip-reconciler-job.yml

# install macvlan
kubectl apply -f cni-install.yml
