## Download Provider
```
$ terraform init
```

## apply terraform scripts
#### When variables are declared in the root module of your configuration, they can be set in a number of ways:
1. Individually, with the -var command line option
2. In variable definitions (.tfvars) files, either specified on the command line or automatically loaded.
```
$ terraform apply -var-file="variables.tfvars"
or
$ terraform apply -var="scraper_image=cyrilsebastian1811/devops7220-scraper" -var="api_image=cyrilsebastian1811/devops7220-api" -var="mongodb_pwd=Onepiece181195" -var="schedule=*/1 * * * *"
```

## destroy
```
$ terraform destroy -var-file="variables.tfvars"
or
$ terraform destroy -var="scraper_image=cyrilsebastian1811/devops7220-scraper" -var="api_image=cyrilsebastian1811/devops7220-api" -var="mongodb_pwd=Onepiece181195" -var="schedule=*/1 * * * *"
```