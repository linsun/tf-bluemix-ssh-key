##############################################################################
# Require terraform 0.9.3 or greater
##############################################################################
terraform {
  required_version = ">= 0.9.3"
}
##############################################################################
# IBM Cloud Provider
##############################################################################
# See the README for details on ways to supply these values
provider "ibmcloud" {
  softlayer_username = "${var.slusername}"
  softlayer_api_key = "${var.slapikey}"
  skip_service_configuration = ["bluemix"]
}

##############################################################################
# IBM SSH Key: For connecting to VMs
##############################################################################
resource "ibmcloud_infra_ssh_key" "ssh_key" {
  label = "${var.key_label}"
  notes = "${var.key_note}"
  # Public key, so this is completely safe
  public_key = "${var.public_key}"
}

##############################################################################
# Variables
##############################################################################
variable slusername {
  description = "Your Softlayer username."
}
variable slapikey {
  description = "Your Softlayer API Key."
}

variable datacenter {
  description = "The datacenter to create resources in."
}
variable public_key {
  description = "Your public SSH key material."
}
variable key_label {
  description = "A label for the SSH key that gets created."
  default = "testing schematics key label"
}
variable key_note {
  description = "A note for the SSH key that gets created."
  default = "testing schematics key label"
}

##############################################################################
# Outputs
##############################################################################
output "ssh_key_id" {
  value = "${ibmcloud_infra_ssh_key.ssh_key.id}"
}
