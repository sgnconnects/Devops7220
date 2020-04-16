# Terraform CMDs
## Download Provider
```
$ terraform init
```

## Apply
#### When variables are declared in the root module of your configuration, they can be set in a number of ways:
1. Individually, with the -var command line option
2. In variable definitions (.tfvars) files, either specified on the command line or automatically loaded.
```
$ terraform apply -var="scraper_image=<dockerhub_username>/devops7220-scraper" -var="api_image=<dockerhub_username>/devops7220-api" -var="mongodb_pwd=<mongodb_password>"
```

## Destroy
```
$ terraform destroy -var="scraper_image=<dockerhub_username>/devops7220-scraper" -var="api_image=<dockerhub_username>/devops7220-api" -var="mongodb_pwd=<mongodb_password>"
```