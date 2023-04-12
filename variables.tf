variable "proxmox_user" {}
variable "proxmox_password" {}

variable "proxmox_url" {
    description = "https://<your proxmox ip address>:8006/api2/json"
    default = "https://proxmox:8006/api2/json"
}

variable "target_node" {
  description = "name of the proxmox machine(usually pve)"
  default = "pve"
}

variable "template_name" {
  description = "the name of the templated created in step 2"
  default = "k8s-template-20.04"
}

variable "cores" {
  description = "number of cores to allocate to each VM"
  default = "4"
}

variable "memory" {
  description = "number of memory to allocate to each VM"
  default = "8192"
}

variable "disk_size" {
  description = "size of disk to allocate to each VM"
  default = "100G"
}

variable "gw_ns" {
  description = "the address of the gateway in your network"
  default = "192.168.100.254"
}

variable "ssh_key_path" {
  description = "path to ssh key in order to manage them"
  sensitive = true
}

variable "storage" {
  description = "the location of which the VMs will be stored"
  default = "ssd500"
}