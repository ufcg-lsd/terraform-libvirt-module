# terraform-libvirt-module
Terraform module for KVM/Libvirt domain.

## Usage

```
terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
  }
}

provider "libvirt" {
  alias = "hostname"
  uri   = "qemu+ssh://ubuntu@hostname/system?sshauth=privkey"
}

module "node_pool_a" {
  source    = "https://github.com/ufcg-lsd/terraform-libvirt-module.git"
  providers = {
    libvirt.alternate = libvirt.hostname
  }
  pool   = "libvirt"
  vcpu   = 8
  memory = "16384"
  disk   = 60 * 1024 * 1024 * 1024
  name   = "domain_name"
  networks = [{
    "interface" : "ens3",
    "bridge" : "br-0",
    "address" : "10.0.1.2",
    "gateway" : "10.6.0.1",
    "mask" : "24",
    "dns" : "8.8.8.8"
    }, {
    "interface" : "ens4",
    "bridge" : "br-1",
    "address" : "10.0.1.2",
    "gateway" : "10.0.1.1",
    "mask" : "24",
    "dns" : "8.8.8.8"
  }]
  cloudinit = {
    hostname       = "hostname",
    admin_username = "ubuntu",
    admin_password = "admin",
    ssh_authorized_keys = [
      "ssh-rsa SOMEKEY"
    ]
  }
  image_source = "https://cloud-images.ubuntu.com/releases/jammy/release/ubuntu-22.04-server-cloudimg-amd64.img"
  image_format = "qcow2"
}
```
