# Cluster Configuration
## Note: before you run this command, please make sure your worker node instance of autoscaling group is in running state
> ```
> vi ./.kube/config.yml
>> replace the value of users[0].user.exec.command from aws to aws2/awscli(depending on what the aws command is on your system) 
>
> kubectl apply -f ./.kube/config-map-aws-auth.yml --kubeconfig=./.kube/config.yml
> ```

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
$ terraform apply -var="scraper_image=<dockerhub_username>/devops7220-scraper" -var="api_image=<dockerhub_username>/devops7220-api" -var="mongodb_pwd=<mongodb_password>" -var="ui_image=<dockerhub_username>/devops7220-ui" -var="schedule=*/1 * * * *"
```

## Destroy
```
$ terraform destroy -var="scraper_image=<dockerhub_username>/devops7220-scraper" -var="api_image=<dockerhub_username>/devops7220-api" -var="mongodb_pwd=<mongodb_password>" -var="ui_image=<dockerhub_username>/devops7220-ui" -var="schedule=*/1 * * * *"
```