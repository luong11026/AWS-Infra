variable "common_tags" {
  type = map(any)

  default = {
    created_by = "terraform"
    owner      = "LuongLa"
  }
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "vpc_name" {
  type    = string
  default = "demo_vpc"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  default = {
    "private_subnet_1" = 1
    "private_subnet_2" = 2
    "private_subnet_3" = 3
  }
}

variable "public_subnets" {
  default = {
    "public_subnet_1" = 1
    "public_subnet_2" = 2
    "public_subnet_3" = 3
  }
}

variable "variables_sub_cidr" {
  type    = string
  default = "10.0.202.0/24"
}

variable "variables_sub_az" {
  type    = string
  default = "ap-southeast-2a"
}

variable "variables_sub_auto_ip" {
  type    = bool
  default = true
}
