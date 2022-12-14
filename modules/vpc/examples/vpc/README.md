# Creating a VPC using AWS VPC Module

[This](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) is a link to the docs on how to use their vpc module but an example is also included in this directory

[This](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/3.14.4?tab=inputs) is a list of all possible inputs for a vpc module

[This](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/3.14.4?tab=outputs) is a list of outputs which can be used


[main.tf](./main.tf) is a simple example which includes:

- azs: availability zone
- cidr: the CIDR block for the VPC
- private_subnets: list of private subnets
- public_subnets: list of public subnets
- public_dedicated_network_acl: sets custom acl for public subnets
- private_dedicated_network_acl: sets custom acl for private subnets
- single_nat_gateway: single shared nat gateway across all private networks
- create_egress_only_igw: creates egress only igw

```terraform init``` will download all the necessary dependencies

```terraform plan``` will display an plan for what will be created in aws

```terraform apply``` would make the changes in aws
