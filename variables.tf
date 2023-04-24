variable "pool" {
  type    = string
  default = "libvirt"
}

variable "memory" {
  type    = string
  default = "4096"
}

variable "vcpu" {
  type    = number
  default = 2
}

variable "disk" {
  type    = number
  default = 40 * 1024 * 1024 * 1024
}

variable "name" {
  type    = string
  default = "name"
}

variable "networks" {
  type = list(
    object({
      interface = string,
      bridge    = string,
      address   = string,
      gateway   = string,
      mask      = string,
      dns       = string
    })
  )
}

variable "cloudinit" {
  type = object({
    hostname            = string,
    admin_username      = string,
    admin_password      = string,
    ssh_authorized_keys = list(string)
  })
}

variable "image_source" {
  type    = string
  default = "https://cloud-images.ubuntu.com/releases/jammy/release/ubuntu-22.04-server-cloudimg-amd64.img"
}

variable "image_format" {
  type    = string
  default = "qcow2"
}
