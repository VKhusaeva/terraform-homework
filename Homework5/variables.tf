variable "region" {
  type = string
}

variable "availability_zones" {
  type = list
}

variable "vpc_cidr" {
  type = string
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

variable "ec2_instances" {
  type  = list(object({
  type  = string
  name  = string
  }))
}
  
variable "ports" {
  type = list
}

variable "dns_support" {
  type = bool
}

variable "dns_hostnames" {
  type = bool
}