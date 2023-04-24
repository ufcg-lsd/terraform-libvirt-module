terraform {
  required_providers {
    libvirt = {
      source                = "dmacvicar/libvirt"
      configuration_aliases = [libvirt.alternate]
    }
  }
}
