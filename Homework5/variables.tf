variable "region" {
  type = string
}

variable "availability_zones" {
  type = list
}

variable "subnets" {
  type = list(object({
  cidr = string
  name = string
  az   = string
  }))
}

variable "route_table_names" {
  type = list 
}

variable "internet_gateway_name" {
  type = string
}

variable "ports" {
  type = list(number)
}

variable "ec2_instances" {
  type  = list(object({
  type  = string
  name  = string
  }))
}
  
variable "vpc_cidr" {
  type          = list(object({
  cidr          = string
  dns_support   = bool
  dns_hostnames = bool
  }))
} 

