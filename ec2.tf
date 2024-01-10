resource "aws_instance" "public_instance_1" {
  ami           = local.ami_amzlinux
  instance_type = var.instance_type

  subnet_id       = "subnet-0cfc361a90d6b20b3"
  security_groups = ["sg-0b3fe6db802396b79"]

  tags = merge({ Name = "public_instance_1" }, var.common_tags)

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_instance" "public_instance_2" {
  ami           = local.ami_amzlinux
  instance_type = var.instance_type

  subnet_id       = "subnet-0cfc361a90d6b20b3"
  security_groups = ["sg-0b3fe6db802396b79"]

  tags = merge({ Name = "public_instance_2" }, var.common_tags)

  lifecycle {
    ignore_changes = all
  }
}
