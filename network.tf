resource "oci_core_vcn" "vcn" {
  compartment_id = var.compartment_ocid
  cidr_block     = "10.0.0.0/16"
  display_name   = "vcn"
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  display_name   = "igw"
  vcn_id         = oci_core_vcn.vcn.id
}

resource "oci_core_route_table" "prt" {
  compartment_id = var.compartment_ocid
  display_name   = "prt"
  vcn_id         = oci_core_vcn.vcn.id

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_subnet" "subnet" {
  availability_domain = ""
  compartment_id      = var.compartment_ocid
  display_name        = "subnet"
  vcn_id              = oci_core_vcn.vcn.id
  cidr_block          = "10.0.1.0/24"
  route_table_id      = oci_core_route_table.prt.id
  security_list_ids   = [oci_core_security_list.securitylist.id]
}

resource "oci_core_security_list" "securitylist" {
  display_name   = "sl"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"
    tcp_options {
      min = 443
      max = 443
    }
  }

  ingress_security_rules {
    protocol = "1" # ICMP
    source   = "0.0.0.0/0"
    icmp_options {
      type = 8 # Allow all ICMP codes
    }
  }
}