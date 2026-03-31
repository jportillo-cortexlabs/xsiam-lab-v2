# Windows Server 2022
data "aws_ami" "windows_server" {
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }
  owners = ["801119661308"] # Canonical
}

# Ubuntu 22.04 oficial de Canonical
data "aws_ami" "ubuntu2204" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "aws_ami" "kali" {
  most_recent = true
  owners      = ["aws-marketplace"]

  filter {
    name   = "name"
    values = ["kali-last-snapshot-amd64-*"]
  }
}

data "aws_ami" "centos9" {
  most_recent = true
  owners      = ["125523088429"] # CentOS official

  filter {
    name   = "name"
    values = ["CentOS Stream 9*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}