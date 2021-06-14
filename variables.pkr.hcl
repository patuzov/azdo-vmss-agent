variable "subscription_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "image_sufix" {
  type = string
}

variable "image_name" {
  default = "azdoagent"
}

variable "resource_group_name" {
  default = "packerdemo"
}

variable "location" {
  default = "West Europe"
}
variable "vm_size" {
  default = "Standard_D2_v3"
}

variable "image_sku" {
  default = "18.04-LTS"
}
