variable "scraper_image" {}

variable "mongodb_usr" {
  default = "root"
  type    = string
}

variable "mongodb_pwd" {}

variable "range" {
  default     = "1mo"
  type        = string
}

variable "interval" {
  default     = "1d"
  type        = string
}

variable "schedule" {
  default     = "0 0 */1 * *"
  type        = string
}

variable "namespace" {
  default     = "scraper"
  type        = string
}