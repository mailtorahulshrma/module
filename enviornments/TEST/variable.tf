variable "rgs" {}
variable "subnets" {}
variable "vnets" {}
variable "vms" {}

variable "storage_accounts" {
  default = {}
}

variable "nsgs" {
  default = {}
}

variable "private_dns_zones" {
  default = {}
}

variable "private_endpoints" {
  default = {}
}
