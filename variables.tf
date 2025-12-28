variable "vms" {
  description = "Un mapa de configuraciones de VMs para crear"
  type        = map(object({
    ip_address  = string
    mac_address = string
    memory      = string
    vcpu        = string
    hostname    = string
  }))
  default = {
    control = {
      ip_address  = "192.168.10.10/24"
      mac_address = "52:54:00:d2:ce:10"
      memory      = "4096"
      vcpu        = "2"
      hostname    = "control"
    }
    nodo1 = {
      ip_address  = "192.168.10.11/24"
      mac_address = "52:54:00:d2:ce:11"
      memory      = "1024"
      vcpu        = "1"
      hostname    = "node1"
    }
    nodo2 = {
      ip_address  = "192.168.10.12/24"
      mac_address = "52:54:00:d2:ce:12"
      memory      = "1024"
      vcpu        = "1"
      hostname    = "node2"
    }
    nodo3 = {
      ip_address  = "192.168.10.13/24"
      mac_address = "52:54:00:d2:ce:13"
      memory      = "1024"
      vcpu        = "1"
      hostname    = "node3"
  }
    nodo4 = {
      ip_address  = "192.168.10.14/24"
      mac_address = "52:54:00:d2:ce:14"
      memory      = "1024"
      vcpu        = "1"
      hostname    = "nodo4"
  }
    nodo5 = {
      ip_address  = "192.168.10.15/24"
      mac_address = "52:54:00:d2:ce:15"
      memory      = "1024"
      vcpu        = "1"
      hostname    = "nodo5"
  }
 }
}
