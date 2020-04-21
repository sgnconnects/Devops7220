variable "ui_image" {}

variable "ui_replicas" {
  default = 3
  type    = number
}

variable "api_host" {}

variable "api_namespace" {
  default = "api"
  type    = string
}

variable "namespace" {
  default = "ui"
  type    = string
}
