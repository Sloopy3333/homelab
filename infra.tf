terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
    }
    ansible = {
      source  = "ansible/ansible"
    }
  }
}

provider "proxmox" {
  pm_api_url = var.pm_api_url
  pm_user = var.pm_user
  pm_password = var.pm_password
  pm_tls_insecure = true
}

resource "ansible_vault" "vault" {
  vault_file          = "group_vars/all/vault.yml"
  vault_password_file = "tmp/vaultpassword"
}

locals {
  decoded_vault_yaml = yamldecode(ansible_vault.vault.yaml)
  sensitive = true
}

variable "pm_api_url" {
  type = string
}
variable "pm_user" {
  type = string
}
variable "pm_password" {
  type = string
  sensitive = true
}
variable "pve_node" {
  type = string
}
variable "vmconfig" {
  type = map
}

resource "proxmox_vm_qemu" "dns" {
  name = var.vmconfig.dns.name
  target_node  = var.pve_node
  vmid = var.vmconfig.dns.vmid
  desc = var.vmconfig.dns.desc

  clone = var.vmconfig.dns.clone
  full_clone = true
  os_type = var.vmconfig.dns.os_type
  qemu_os = "l26"

  cpu = var.vmconfig.dns.cpu
  cores = var.vmconfig.dns.cores

  memory = var.vmconfig.dns.memory
  balloon = var.vmconfig.dns.balloon

  scsihw = "virtio-scsi-pci"
  disk {
    slot = 0
    type = "scsi"
    storage = "local-lvm"
    size = var.vmconfig.dns.disksize
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
    firewall = false
  }
  network {
    model = "virtio"
    bridge = "vmbr1"
    firewall = false
  }

  ipconfig0 = var.vmconfig.dns.ipconfig0
  ipconfig1 = var.vmconfig.dns.ipconfig1

  serial {
    id = 0
    type = "socket"
  }

  onboot = var.vmconfig.dns.onboot
  agent = var.vmconfig.dns.agent
  tags = var.vmconfig.dns.tags
  
  lifecycle {
    ignore_changes = [ cicustom ]
  }
}

resource "proxmox_vm_qemu" "services" {
  name = var.vmconfig.services.name
  target_node  = var.pve_node
  vmid = var.vmconfig.services.vmid
  desc = var.vmconfig.services.desc

  clone = var.vmconfig.services.clone
  full_clone = true
  os_type = var.vmconfig.services.os_type
  qemu_os = "l26"

  cpu = var.vmconfig.services.cpu
  cores = var.vmconfig.services.cores

  memory = var.vmconfig.services.memory
  balloon = var.vmconfig.services.balloon

  scsihw = "virtio-scsi-pci"
  disk {
    slot = 0
    type = "scsi"
    storage = "local-lvm"
    size = var.vmconfig.services.disksize
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
    firewall = false
  }
  network {
    model = "virtio"
    bridge = "vmbr1"
    firewall = false
  }

  ipconfig0 = var.vmconfig.services.ipconfig0
  ipconfig1 = var.vmconfig.services.ipconfig1

  serial {
    id = 0
    type = "socket"
  }

  onboot = var.vmconfig.services.onboot
  agent = var.vmconfig.services.agent
  tags = var.vmconfig.services.tags
  
  lifecycle {
    ignore_changes = [ cicustom ]
  }
}

resource "proxmox_vm_qemu" "watcher" {
  name = var.vmconfig.watcher.name
  target_node  = var.pve_node
  vmid = var.vmconfig.watcher.vmid
  desc = var.vmconfig.watcher.desc

  clone = var.vmconfig.watcher.clone
  full_clone = true
  os_type = var.vmconfig.watcher.os_type
  qemu_os = "l26"

  cpu = var.vmconfig.watcher.cpu
  cores = var.vmconfig.watcher.cores

  memory = var.vmconfig.watcher.memory
  balloon = var.vmconfig.watcher.balloon

  scsihw = "virtio-scsi-pci"
  disk {
    slot = 0
    type = "scsi"
    storage = "local-lvm"
    size = var.vmconfig.watcher.disksize
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
    firewall = false
  }
  network {
    model = "virtio"
    bridge = "vmbr1"
    firewall = false
  }

  ipconfig0 = var.vmconfig.watcher.ipconfig0
  ipconfig1 = var.vmconfig.watcher.ipconfig1

  serial {
    id = 0
    type = "socket"
  }

  onboot = var.vmconfig.watcher.onboot
  agent = var.vmconfig.watcher.agent
  tags = var.vmconfig.watcher.tags
  
  lifecycle {
    ignore_changes = [ cicustom ]
  }
}