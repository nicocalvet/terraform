
resource "aws_instance" "instance-ec2" {
  count         = 3
  ami           = element(var.amis, count.index)
  instance_type = "t3.micro"
  tags = {
    Name        = "${var.name}-${count.index}"
    Environment = "Dev"
  }
  subnet_id = "subnet-02dbf55cf4ab64fc4"
}

terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-nicolas"
    key            = "tfstate/my_terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    dynamodb_table = "terraform_Nicolas_lock"
  }
}


variable "name" {
  description = "Le nom de l'instance EC2"
  default     = "terraform-Nicolas-1"
}
variable "amis" {
  description = "amis des instances EC2"
  type        = list(any)
  default     = ["ami-05edb7c94b324f73c", "ami-05edb7c94b324f73c", "ami-05edb7c94b324f73c"]
}
variable "instance_type" {
  description = "Le type de l'instance"
  default     = "t3.micro"
}
variable "subnet_id" {
  description = "Le subnet"
  default     = "subnet-02dbf55cf4ab64fc4"

}
variable "port" {
  type        = number
  description = "Numéro de port"
  default     = 80

}