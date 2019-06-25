//data "aws_availability_zones" "all" {}
//data "aws_subnet_ids" "public" {
//  vpc_id = "${aws_vpc.helloworld_vpc.id}"
//}

variable "rds_username" {}

variable "rds_password" {}

variable "domain" {
  default = "justanother.engineer"
}

variable "helloworld_dns_record" {
  default = "helloworld"
}
variable "helloworld_docker_image" {
  default = "luiz1361/helloworld"
}

variable "helloworld_port" {
  default = 8081
}
variable "busybox_port" {
  default = 8080
}

variable "aws_region" {
  default = "us-east-1"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default     = "ami-024a64a6685d05041"
}

variable "ec2_instance_type" {
  default = "t2.micro"
}

variable "rds_instance_type" {
  default = "db.t2.micro"
}

variable "rds_storage" {
  default = "20"
}

variable "asg_min" {
  default = "2"
}

variable "asg_max" {
  default = "2"
}

variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

variable "subnets_cidr" {
  type    = "list"
  default = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
}

variable "azs" {
  type    = "list"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "bucketname" {
  default = "helloworlddockerswarmmanagertoken"
}