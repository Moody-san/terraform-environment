variable "servers" {
  default = [
    {
      display_name = "server01"
      cpu          = 2
    },
    {
      display_name = "server02"
      cpu          = 1
    },
    {
      display_name = "server03"
      cpu          = 1
    }
  ]
}

module "server" {
  source         = "../compute_module"
  for_each = {for server in var.servers:  server.display_name => server}
  compartment_id = var.compartment_ocid
  AD             = data.oci_identity_availability_domains.ads.availability_domains[2]["name"] // for ad=3
  subnet_id      = oci_core_subnet.subnet.id
  display_name   = each.value.display_name
  cpu            = each.value.cpu
}


output "server_public_ip" {
  value = { for k, v in module.server : k => v.compute_public_ip }
}
