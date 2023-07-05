variable "image_shape" {
  default = "VM.Standard.A1.Flex"
}

variable "boot_volume" {
  default = "50"
}

variable "cpu" {
  default = "1"
}

variable "memory" {
  default = "8"
}

variable "display_name" {
  default = "server"
}


// change this
variable "image_id" {
  default = "your image ocid"
}


variable "ssh_key" {
  default = "your key path"
}


//required
variable "compartment_id" {

}

variable "AD" {
}

variable "subnet_id" {

}
