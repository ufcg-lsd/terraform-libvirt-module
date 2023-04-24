ethernets:
  %{~ for interface in configs ~}
  ${interface.interface}:
      addresses:
      - ${interface.address}/${interface.mask}
      dhcp4: false
      gateway4: ${interface.gateway}
      nameservers:
        addresses:
        - ${interface.dns}
  %{~ endfor ~}
version: 2
