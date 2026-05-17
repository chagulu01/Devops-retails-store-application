

variable "environment_name" {
  description = "The name of the environment (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"

}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"

}

variable "tags" {
  description = "A map of tags to apply to all resources."
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "my-terraform-project"
  }

}

variable "subnet_newbits" {
  description = "The number of new bits to add to the VPC CIDR block for subnets."
  type        = number
  default     = 8

}