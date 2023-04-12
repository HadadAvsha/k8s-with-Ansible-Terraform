# Setting up  k8s cluster using Ansible and Terraform in Proxmox<br/>
## Some prerequisite:<br/>
1. install proxmox and [setup requirement for terraform](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs).<br/>
2. create init-cloud image using this [guide](https://tcude.net/creating-a-vm-template-in-proxmox/) and install [this](https://www.learnlinux.tv/how-to-build-an-awesome-kubernetes-cluster-using-proxmox-virtual-environment/) before capturing. <br/>
3. clone repo and create new terraform.tfvars and enter the following info:
    *   `proxmox_user` = proxmox username created in step 1
    *   `proxmox_password` = proxmox password created in step 1
    *   `ssh_key_path` = ssh key location for ansible to manage created VMs.
4. in `variables.tf` change values<br/>
5. in `main.tf` enter the correct ip range (@ipconfig0 section)<br/>
6. in ansible folder:
    *   if you setup NFS share uncomment the corresponding line in `all_pre.yml` and `SC-openEBS.yml`
    *   for use of load balancer in k8s uncomment the `MetalLB.sh` and change the values in the `cidr_block line` and `ingress` lines
11. `terraform init` > `terraform plan` > `terraform apply`.<br/>