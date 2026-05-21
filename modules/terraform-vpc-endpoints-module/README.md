# module: terraform-vpc-endpoints-module

Reusable AWS VPC Endpoints module for ECR, SSM, CloudWatch interface endpoints and S3 gateway endpoint

## Usage

```hcl
module "terraform-vpc-endpoints-module" {
  source = "git::https://github.com/grsuresh4u/terraform-vpc-endpoints-module.git//modules/terraform-vpc-endpoints-module?ref=main"
}
```
