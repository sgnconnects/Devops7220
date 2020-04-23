provider "kubernetes" {
  config_path = "./.kube/config.yml"
}

# provider "helm" {
#   kubernetes {
#     config_path = "./.kube/config.yml"
#   }
# }

# # Helm Provider modules
# module "addons" {
#   source        = "./modules/addons"
#   providers = {
#     helm = helm
#   }
# }


# Kubernetes Provider modules
variable "scraper_image" {}
variable "api_image" {}
variable "ui_image" {}
variable "mongodb_pwd" {}
variable "schedule" {
  default = "0 0 */1 * *"
  type    = string
}

module "scraper" {
  source        = "./modules/scraper"
  scraper_image = var.scraper_image
  mongodb_pwd   = var.mongodb_pwd
  schedule      = var.schedule
  providers = {
    kubernetes = kubernetes
  }
}

module "api" {
  source      = "./modules/api"
  api_image   = var.api_image
  mongodb_pwd = var.mongodb_pwd
  providers = {
    kubernetes = kubernetes
  }
}

module "ui" {
  source = "./modules/ui"
  ui_image = var.ui_image
  api_host = "${module.api.api_host}"
  providers = {
    kubernetes = kubernetes
  }
}

module "metrics" {
  source = "./modules/metrics"
  providers = {
    kubernetes = kubernetes
  }
}


