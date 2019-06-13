data "aws_availability_zones" "all" {}

variable "rds_username" {}

variable "rds_password" {}

variable "domain" {
  default = "justanother.engineer"
}

variable "app_dns_record" {
  default = "helloworld"
}
variable "app_docker_image" {
  default = "luiz1361/helloworld"
}

variable "app_port" {
  description = "The port the server will use for HTTP requests"
  default = 8081
}
variable "busybox_port" {
  description = "The port the server will use for HTTP requests"
  default = 8080
}

variable "aws_region" {
  description = "AWS region on which we will be working on"
  default = "us-east-1"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default = "ami-024a64a6685d05041"
}

variable "ec2_instance_type" {
  description = "EC2 Instance type"
  default = "t2.micro"
}

variable "rds_instance_type" {
  description = "RDS Instance Type"
  default = "db.t2.micro"
}

variable "asg_min" {
  description = "Min qty of servers in ASG"
  default     = "1"
}

variable "asg_max" {
  description = "Max qty of servers in ASG"
  default     = "1"
}

variable "vpc_cidr" {
	default = "10.20.0.0/16"
}

variable "subnets_cidr" {
	type = "list"
	default = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "azs" {
	type = "list"
	default = ["us-east-1a", "us-east-1b"]
}

variable "bucketname"{
  default = "aksjdajsd10dj91j0d101dj"
}