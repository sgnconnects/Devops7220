variable "namespace" {
  default     = "monitoring"
  type        = string
}

variable "prometheus_replicas" {
  default = 1
  type    = number
}

variable "grafana_replicas" {
  default = 1
  type    = number
}

variable "kube_state_replicas" {
  default = 1
  type    = number
}