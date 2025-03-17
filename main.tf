terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18.0"
    }
  }

  backend "s3" {
    bucket         	   = "craig-refactor-tfstate"
    key              	   = "state/terraform-testing.tfstate"
    region         	   = "us-west-2"
    encrypt        	   = true
    use_lockfile = true
  }
}

locals {
  all_cidrs = concat(var.eks_cidr_block, var.private_cidr_block)
}

resource "aws_security_group" "msk_sg" {
    for_each = var.security_groups
    name        = each.key
    vpc_id      = "vpc-039c29e549919a4f4"

    ingress {
        from_port   = each.value.from_port
        to_port     = each.value.to_port
        protocol    = each.value.protocol
        #cidr_blocks = local.all_cidrs
        cidr_blocks = concat(var.eks_cidr_block, var.private_cidr_block)
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = var.tags
}