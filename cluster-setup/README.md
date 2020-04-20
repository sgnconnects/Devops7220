## Infrastructure Setup Commands

#### 1. Terraform apply
```
terraform apply -var="aws-profile=dev"
```

#### 2. Creating kubernetes config file
```
terraform output config_map_aws_auth > ../kubernetes/.kube/config-map-aws-auth.yml
terraform output kubeconfig > ../kubernetes/.kube/config.yml
kubectl apply -f ../kubernetes/.kube/config-map-aws-auth.yml --kubeconfig=../kubernetes/.kube/config.yml
```

#### Infrastructure Destroy Commands
```
terraform destroy -var="aws-profile=dev"
```