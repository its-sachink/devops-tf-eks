variable "AWS_REGION" {}
variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}

locals {
  env = "${terraform.workspace}"

  availabilityzone = "${var.AWS_REGION}a"
  availabilityzone2 = "${var.AWS_REGION}b"

  cluster_name= "${local.env}-cluster"

//  NOTE: The usage of the specific kubernetes.io/cluster/*
//  resource tags below are required for EKS and Kubernetes to discover
//  and manage networking resources.

  common_tags = "${map(
    "Environment", "${local.env}",
    "kubernetes.io/cluster/${local.cluster_name}", "shared"
  )}"
}

variable "ec2_keyname" {
  description = "key used to access instances"
  default = "EKS"
}


variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default = "10.11.0.0/16"
}


// Primary pair of public/private networks

variable "public_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default = "10.11.0.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the Private Subnet"
  default = "10.11.1.0/24"
}


// Secondary pair of public/private networks (if you ever needed that)

variable "public_subnet_cidr2" {
  description = "CIDR for the Public Subnet"
  default = "10.11.2.0/24"
}

variable "private_subnet_cidr2" {
  description = "CIDR for the Private Subnet"
  default = "10.11.3.0/24"
}