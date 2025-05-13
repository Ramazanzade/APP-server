variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  description = "Ubuntu 20.04 AMI ID for us-east-1"
  default     = "ami-053b0d53c279acc90"  # Ubuntu Server 20.04 LTS (us-east-1 üçün)
}
