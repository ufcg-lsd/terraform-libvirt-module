output "server_addresses" {
  value = libvirt_domain.vm.network_interface.*.addresses
}
