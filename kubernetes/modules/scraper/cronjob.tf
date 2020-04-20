resource "kubernetes_namespace" "scraper" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_secret" "mongodb-auth-secrets" {
  depends_on = [
    kubernetes_namespace.scraper
  ]

  metadata {
    name = "mongodb-auth-secrets"
    namespace = var.namespace
    labels = {
      app = "devops7220-final"
    }
  }

  data = {
    MONGODB_USR = var.mongodb_usr
    MONGODB_PWD = var.mongodb_pwd
  }

  type = "Opaque"
}

resource "kubernetes_cron_job" "scraper-cron-job" {
  depends_on = [
    kubernetes_namespace.scraper
  ]
  metadata {
    name      = "scraper-cron-job"
    namespace = var.namespace
    labels = {
      app = "devops7220-final-scraper"
    }
  }
  spec {
    schedule = var.schedule
    job_template {
      metadata {
        labels = {
          app = "devops7220-final-scraper"
        }
      }
      spec {
        template {
          metadata {
            labels = {
              app = "devops7220-final-scraper"
            }
          }
          spec {
            container {
              name    = "scraper-container"
              image   = var.scraper_image
              command = ["python3", "/scraper/yahoo-scraper.py"]
              args    = ["-r", var.range, "-i", var.interval]

              env_from {
                secret_ref {
                  name = "mongodb-auth-secrets"
                }
              }
            }
            restart_policy = "OnFailure"
          }
        }
      }
    }
  }
}
