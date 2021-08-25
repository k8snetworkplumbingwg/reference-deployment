## Multus (Cilium as cluster network)

This yaml files install Multus and Cilium in your Kubernetes cluster. Both installations are done as a daemonset.

## How to Use

```
$ cat multus-daemonset.yml cilium-daemonset.yml | kubectl apply -f -
```
## Note

For convenience, `cilium-daemonset.yml` uses `cni-install.sh` to install the Cilium binary on the host. This has the side-effect
of also installing a network configuration for Cilium at `/etc/cni/net.d/05-cilium.conf`. We override this network configuration
by installing the Multus network configuation at `/etc/cni/net.d/02-multus.conf`.
