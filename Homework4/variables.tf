variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "key_name" {
  description = "Name of the key pair"
  type        = string

}

variable "ports" {
  description = "List of ports to open"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "availability_zone" {
  description = "Availability zone to deploy the instance"
  type        = string
}

variable "instance_type" {
  description = "Type of instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
}