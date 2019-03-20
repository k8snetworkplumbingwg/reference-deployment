## Multus (flannel as cluster network)

This yaml files install multus and flannel in your Kubernetes cluster. Both installation is done as daemonset.

## How to Use

```
$ cat multus-daemonset.yml flannel-daemonset.yml | kubectl apply -f -
```
