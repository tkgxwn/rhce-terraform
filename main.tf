terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_cloudinit_disk" "commoninit" {
  for_each = var.vms
  name     = "${each.key}-cloudinit.iso"
  pool     = "images"
  user_data = templatefile("${path.module}/user-data.yaml", {
    hostname = each.value.hostname
    ssh_host_ed25519 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPv1nl6z1uioJVWXWOOr46PhurJhz93N8CSQsX7LudHn"
    ssh_host_rsa     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCn9FdM5kB91G39EoHrae02mo2tR+IDdjjNUEkKdqL34jYdJEgVw7j0/FM93TTiIHz+LgpDjjePzCtvNXCJllyVv5aC7L/qnnjrHVCX/cMay74/vwAIL87FDxDC4sEtNb0h+9+bh4tNB41TV/EdPJtQotqIrdNnFpmLqXlzq0g8emum19UWfSmLM7aGAh2QlF6jngC/5BhCBVfWpNu9tW0yZndNkszRutse7+w4QAaHJxyT2kBtvNfy7vz716e3eue2kTQ0SFZlctq/wLgSYlWaw0VCTLBPMqglWR4CspPJanVdn+4Px+rtA/AwxutntmCqNa/A9L/wDmk1Gqb2KnwrpoComf2IBqtj7NE86hGpqghYyPUFlFW4fZDaGRFKXY+95a6RS1iq+B0oH4xLj/22Sm8rQBYvM/P+sHHUaVswmFRqVR39evjb30wcz2aA3LxAD6em7G2UvPnR6VJE1LGaCbtYSSpdZcixRylIL6u6val5uBdKrHSzPmNCxgbNQq8="
    ssh_host_ecdsa   = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBHewKY/w6XjteUQ7PcXjZ5MqadVQXaVShex6Bsvjhx3VpIirDMyv2b1clBVmZUaIoproNyN5p1AnX9mJGond2kQ="
  })
  
  network_config   = templatefile("${path.module}/network-config.yaml", {
    mac_address = each.value.mac_address
    ip_address  = each.value.ip_address
  })
}

resource "libvirt_volume" "example" {
  for_each = var.vms
  name   = "${each.key}-disk"
  pool   = "images"
  format = "qcow2"
  source = "/data/bkp/rocky9.qcow2"
}

resource "libvirt_domain" "example" {
  for_each = var.vms
  name   = each.value.hostname
  memory = each.value.memory
  vcpu   = each.value.vcpu

  cloudinit = libvirt_cloudinit_disk.commoninit[each.key].id
  cpu {
    mode = "host-passthrough"
  }
  network_interface {
    network_name = "rhce"
    mac          = each.value.mac_address
  }
  disk {
    volume_id = libvirt_volume.example[each.key].id
  }
  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
  graphics {
    type        = "vnc"
    listen_type = "address"
    autoport    = true
  }
}
