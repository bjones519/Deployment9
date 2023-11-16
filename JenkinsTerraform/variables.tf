#################### variables ####################

#################### AWS credentials ####################

variable "access_key" {}
variable "secret_key" {}

#################### SSH key ####################
variable "key_name" {}

#################### Regions ####################
variable "region" {
  default = "us-east-1"
}

#################### EC2 Config ####################
variable "vpc_id" {}

variable "deployment9_instance_type" {
  default = "t2.medium"
}

variable "ami" {
  default = "ami-053b0d53c279acc90"
}

variable "subnet_id" {
  default = "subnet-098c6f6d70b6fbfce"
}

variable "subnet_id2" {
  default = "subnet-0427a771f050fbb05"
}