## Multus (calico as cluster network)

This yaml files install multus and calico in your Kubernetes cluster. Both installation is done as daemonset.

## How to Use

```
$ cat multus-daemonset.yml calico-daemonset.yml | kubectl apply -f -
```
