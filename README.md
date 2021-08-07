Terraform code to deploy three-tier architecture on azure

Terraform is chosen for the implemetation of this three-tier architecture of an ónlinetechchallenge'app as it isn open source IaaC platform provided by Hashicorp and is written in HCL language and Go Libraries.

Three-tier architecture
A monotlith architecture of setting up application in which the architecture is divided into three tiers as database tier and app tier in private subnet and web based tier in public frontend.


Deployment
Steps
Step 0 terraform init

used to initialize a working directory containing Terraform configuration files

Step 1 terraform plan

used to create an execution plan

Step 2 terraform validate

validates the configuration files in a directory, referring only to the configuration and not accessing any remote services such as remote state, provider APIs, etc

Step 3 terraform apply

used to apply the changes required to reach the desired state of the configuration