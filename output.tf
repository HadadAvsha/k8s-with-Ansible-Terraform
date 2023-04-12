output "workers_ip_address" {
  description = "Workers IP Default"
  value = proxmox_vm_qemu.kube-node.*.default_ipv4_address
}

output "controlplane_ip_address" {
  description = "Master IP Default"
  value = proxmox_vm_qemu.controlplane.*.default_ipv4_address
}