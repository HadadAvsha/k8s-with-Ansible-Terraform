resource "null_resource" "ConfigureAnsibleLabelVariable" {
  provisioner "local-exec" {
    command = "echo '[all]' > ./ansible/hosts"
  }
  provisioner "local-exec" {
    command = "echo '${proxmox_vm_qemu.controlplane[0].default_ipv4_address}' >> ./ansible/hosts"
  }
  provisioner "local-exec" {
    command = "echo '${proxmox_vm_qemu.kube-node[0].default_ipv4_address}' >> ./ansible/hosts"
  }
    provisioner "local-exec" {
    command = "echo '${proxmox_vm_qemu.kube-node[1].default_ipv4_address}' >> ./ansible/hosts"
  }
  provisioner "local-exec" {
    command = "echo '\\n[masters]' >> ./ansible/hosts"
  }
    provisioner "local-exec" {
    command = "echo '${proxmox_vm_qemu.controlplane[0].default_ipv4_address}' >> ./ansible/hosts"
  }
    provisioner "local-exec" {
    command = "echo '\\n[workers]' >> ./ansible/hosts"
  }
    provisioner "local-exec" {
    command = "echo '${proxmox_vm_qemu.kube-node[0].default_ipv4_address}' >> ./ansible/hosts"
  }
    provisioner "local-exec" {
    command = "echo '${proxmox_vm_qemu.kube-node[1].default_ipv4_address}' >> ./ansible/hosts"
  }

    depends_on = [proxmox_vm_qemu.controlplane]
}

resource "null_resource" "CopyFiles" {
  connection {
    type = "ssh"
    user = "ubuntu"
    host = "${proxmox_vm_qemu.controlplane[0].default_ipv4_address}"
    private_key = "${file("${var.ssh_key_path}")}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'health check'"
    ]
  }
    depends_on = [null_resource.ConfigureAnsibleLabelVariable]
}

resource "null_resource" "ModifyApplyAnsiblePlayBook" {
    provisioner "local-exec" {
        # command = "sleep 10; bash ./ansible/run.sh"
        command = <<-EOT
          sleep 10
          cd ./ansible
          echo "Copy necessary files to /tmp"
          cp Metrics-server.yml StorageClass.yml SC-openEBS.yml MetalLB.sh /tmp/
          echo "Running Prerequisites installations on all VMs"
          ansible-playbook -i hosts all_pre.yml
          echo "Setting up the controlplane"
          ansible-playbook -i hosts masters_playbook.yml
          echo "Setting up the worker nodes"
          sleep 10
          ansible-playbook -i hosts workers_playbook.yml
          echo "Setting up kube/config"
          mv fetched/admin.conf ~/.kube/config
          echo "chmoding .kube/config to only readable by me"
          chmod 600 ~/.kube/config
          until kubectl get nodes | grep -i "Ready"; do sleep 1 ;  done > /dev/null
        EOT
    }
  depends_on = [null_resource.CopyFiles]
}
# kubectl patch configmaps argocd-cm --patch-file argocd-cm-patch.yml

resource "null_resource" "PostConfigInstalls" {
  connection {
    type = "ssh"
    user = "ubuntu"
    host = "${proxmox_vm_qemu.controlplane[0].default_ipv4_address}"
    private_key = "${file("${var.ssh_key_path}")}"
  }

  provisioner "remote-exec" {
    inline = [
        "bash ~/MetalLB.sh"
    ]
  }
    depends_on = [null_resource.ModifyApplyAnsiblePlayBook]
}