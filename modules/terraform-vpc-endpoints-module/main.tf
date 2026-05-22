locals {
  interface_services = {
    ecr_api     = "com.amazonaws.${var.region}.ecr.api"
    ecr_dkr     = "com.amazonaws.${var.region}.ecr.dkr"
    ssm         = "com.amazonaws.${var.region}.ssm"
    ssmmessages = "com.amazonaws.${var.region}.ssmmessages"
    ec2messages = "com.amazonaws.${var.region}.ec2messages"
    logs        = "com.amazonaws.${var.region}.logs"
  }
}

resource "aws_vpc_endpoint" "interface" {
  for_each = local.interface_services

  vpc_id              = var.vpc_id
  service_name        = each.value
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = true

  tags = merge(var.tags, { Name = "${lookup(var.tags, "Name", "endpoint")}-${each.key}" })
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.route_table_ids

  tags = merge(var.tags, { Name = "${lookup(var.tags, "Name", "endpoint")}-s3" })
}
