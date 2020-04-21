## Infrastructure Setup Commands
The deafult <region> of cluster deployment is us-east-1, please change the region in main.tf provider section

#### 1. Terraform apply
```
terraform apply
or
terraform apply -var="aws-profile=dev"
```

#### 2. Creating kubernetes config file
```
terraform output config_map_aws_auth > ../kubernetes/.kube/config-map-aws-auth.yml
terraform output kubeconfig > ../kubernetes/.kube/config.yml
```

#### Infrastructure Destroy Commands
```
terraform destroy
or
terraform destroy -var="aws-profile=dev"
```