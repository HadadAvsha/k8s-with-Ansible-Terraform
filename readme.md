<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 2.9.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 2.9.8 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [proxmox_vm_qemu.controlplane](https://registry.terraform.io/providers/telmate/proxmox/2.9.8/docs/resources/vm_qemu) | resource |
| [proxmox_vm_qemu.kube-node](https://registry.terraform.io/providers/telmate/proxmox/2.9.8/docs/resources/vm_qemu) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_controlplane_ip_address"></a> [controlplane\_ip\_address](#output\_controlplane\_ip\_address) | Current IP Default |
| <a name="output_kube-node_ip_address"></a> [kube-node\_ip\_address](#output\_kube-node\_ip\_address) | Current IP Default |
<!-- END_TF_DOCS -->