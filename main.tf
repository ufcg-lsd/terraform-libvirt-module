resource "libvirt_volume" "base_volume" {
  provider = libvirt.alternate
  name     = "${var.name}_base_volume.qcow2"
  pool     = var.pool
  source   = var.image_source
  format   = var.image_format
}

resource "libvirt_volume" "base_volume_resized" {
  provider       = libvirt.alternate
  name           = "${var.name}_resized.qcow2"
  pool           = var.pool
  base_volume_id = libvirt_volume.base_volume.id
  size           = var.disk
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  provider = libvirt.alternate
  name     = "${var.name}_cloudinit.iso"
  pool     = var.pool
  user_data = templatefile("${path.module}/templates/user_data.tpl", {
    configs = var.cloudinit
  })
  network_config = templatefile("${path.module}/templates/network_config.tpl", {
    configs = var.networks
  })
}

resource "libvirt_domain" "vm" {
  provider   = libvirt.alternate
  name       = var.name
  memory     = var.memory
  vcpu       = var.vcpu
  qemu_agent = true
  autostart  = true
  cloudinit  = libvirt_cloudinit_disk.cloudinit.id

  dynamic "network_interface" {
    for_each = var.networks
    content {
      network_name = network_interface.value.bridge
      bridge       = network_interface.value.bridge
      addresses    = [network_interface.value.address]
    }
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_port = "1"
    target_type = "virtio"
  }

  disk {
    volume_id = libvirt_volume.base_volume_resized.id
  }

}
