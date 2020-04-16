provider "kubernetes" {
    config_path= "~/.kube/config"
}

variable "scraper_image" {}
variable "api_image" {}
variable "mongodb_pwd" {}
variable "schedule" {
  default     = "0 0 */1 * *"
  type        = string
}

module "global_variables" {
  source = "./modules/global"
}

module "scraper" {
  source = "./modules/scraper"
  scraper_image = var.scraper_image
  mongodb_pwd = var.mongodb_pwd
  schedule = var.schedule
}

module "api" {
  source = "./modules/api"
  api_image = var.api_image
  mongodb_pwd = var.mongodb_pwd
}

module "metrics" {
  source = "./modules/metrics"
}