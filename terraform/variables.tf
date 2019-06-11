variable "domain" {
  default = "justanother.engineer"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = 8080
}

variable "aws_region" {
  description = "AWS region on which we will setup the swarm cluster"
  default = "us-east-1"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default = "ami-024a64a6685d05041"
}

variable "instance_type" {
  description = "Instance type"
  default = "t2.micro"
}