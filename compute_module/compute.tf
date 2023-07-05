resource "oci_core_instance" "server" {
  availability_domain = var.AD             //
  compartment_id      = var.compartment_id //
  display_name        = var.display_name
  shape               = var.image_shape

  create_vnic_details {
    subnet_id        = var.subnet_id //
    assign_public_ip = true
  }
  source_details {
    source_type             = "image"
    source_id               = var.image_id
    boot_volume_size_in_gbs = var.boot_volume
  }
  shape_config {
    ocpus         = var.cpu
    memory_in_gbs = var.memory
  }
  metadata = {
    ssh_authorized_keys = file(var.ssh_key)
  }
}

output "compute_public_ip" {
  value = oci_core_instance.server.public_ip
}