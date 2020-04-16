variable "mongodb_usr" {
  default = "root"
  type    = string
}

variable "mongodb_pwd" {}

variable "api_image" {}

variable "api_replicas" {
  default = 3
  type    = number
}

variable "namespace" {
  default = "api"
  type    = string
}
