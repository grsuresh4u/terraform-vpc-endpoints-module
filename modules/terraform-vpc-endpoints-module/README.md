# terraform-vpc-endpoints-module

Reusable Terraform module for provisioning AWS VPC Endpoints — six Interface endpoints for private AWS service access and one S3 Gateway endpoint. Designed for air-gapped or private-subnet deployments where instances have no internet access.

## Services Covered

### Interface Endpoints (PrivateLink)
| Key | Service |
|-----|---------|
| `ecr_api` | `ecr.api` — ECR control plane |
| `ecr_dkr` | `ecr.dkr` — Docker image pulls from ECR |
| `ssm` | `ssm` — SSM parameter store and agent |
| `ssmmessages` | `ssmmessages` — SSM Session Manager |
| `ec2messages` | `ec2messages` — EC2 Systems Manager messages |
| `logs` | `logs` — CloudWatch Logs |

### Gateway Endpoint
| Key | Service |
|-----|---------|
| `s3` | S3 — routed via route table, no data transfer cost |

## Usage

```hcl
module "vpc_endpoints" {
  source = "github.com/grsuresh4u/terraform-vpc-endpoints-module?ref=v1.0.0"

  vpc_id             = "vpc-0abc123"
  subnet_ids         = ["subnet-0abc123"]
  route_table_ids    = ["rtb-0abc123"]
  security_group_ids = ["sg-0abc123"]
  region             = "us-east-1"

  tags = {
    Name        = "my-endpoints"
    Environment = "dev"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `vpc_id` | VPC ID | `string` | - | yes |
| `subnet_ids` | Private subnet IDs for interface endpoints | `list(string)` | - | yes |
| `route_table_ids` | Route table IDs for S3 gateway endpoint | `list(string)` | - | yes |
| `security_group_ids` | Security group IDs for interface endpoints | `list(string)` | - | yes |
| `region` | AWS region | `string` | - | yes |
| `tags` | Map of tags to apply | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `endpoint_ids` | Map of interface endpoint keys to endpoint IDs |
| `s3_endpoint_id` | ID of the S3 gateway endpoint |
