terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.8"
    }
  }
}

provider "proxmox" {
  pm_api_url = var.proxmox_url
  pm_api_token_id = var.proxmox_user
  pm_api_token_secret = var.proxmox_password
  pm_tls_insecure = true
}