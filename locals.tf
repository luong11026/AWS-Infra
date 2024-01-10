locals {
  account_id     = data.aws_caller_identity.current.account_id
  account_region = data.aws_region.current
  key_name       = "luongla"

  ami_amzlinux = data.aws_ami.aws_linux.image_id
}
