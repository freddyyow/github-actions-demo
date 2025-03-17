variable "tags" {
  default = {}
}

variable "security_groups" {
    type = map(object({
        from_port = number
        to_port = number
        protocol = optional(string, "tcp")
    }))
    default = {
        test1 = {
            from_port = 8080
            to_port = 8080
        }
        test2 = {
            from_port = 1111
            to_port = 1111
            protocol = "udp"
        }
    }
  
}

variable "eks_cidr_block" {
  description = "The CIDR block for the first EKS subnet"
  type        = list(string)
  
  default = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/28"]
}

variable "private_cidr_block" {
  description = "The CIDR block for the second private subnet"
  type        = list(string)

  default = ["10.0.200.0/24", "10.0.201.0/24"]
}