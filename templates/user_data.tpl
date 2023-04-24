#cloud-config
# vim: syntax=yaml
hostname: ${configs.hostname}
manage_etc_hosts: true
users:
  - name: ${configs.admin_username}
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
    %{~ for key in configs.ssh_authorized_keys ~}
      - ${key}
    %{~ endfor ~}
    shell: /bin/bash
    home: /home/${configs.admin_username}
disable_root: false
%{~ if configs.admin_password != "" }
ssh_pwauth: true
chpasswd:
  list: |
    ${configs.admin_username}:${configs.admin_password}
  expire: false
%{~ endif}
growpart:
  mode: auto
  devices: ['/']
