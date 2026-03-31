# XSIAM-LAB-V2

Infrastructure as Code to deploy an XSIAM lab using **Terraform** and **GitHub Actions**.

---

## Description

This repository defines a complete lab environment including:

- Network (VPC, subnets, routing)
- Jumpbox (the only one with Public IP)
- Palo Alto VM-Series Firewall - BYOL - 4 vCPU
- XSIAM components (optional)
    -   Broker VM  
    -   Engine 
- Virtual machines
    -   Windows Server 2022
    -   Linux Ubuntu 22.04
    -   Kali Linux

The deployment is fully automated and reproducible using Terraform.

---

## Prerequisites

### AWS

An AWS account with permissions to create:

- EC2
- VPC
- Subnets
- Security Groups
- Route Tables
- Internet Gateway
- Elastic IP
- S3 (for backend)

Once with the AWS Account, you'll need to create and configure manually:

- EC2 Key Pair (download the private key)
- S3 Bucket for Terraform Backend (S3_BACKEND)
- AWS Access Key / AWS Access Key Secret
- Configure AWS CLI (optional)

You'll need a Github account and fork this repo to create yours. On the repository Settings > Secrets and Variables > Actions, create these Repository Secrets/Variables:

-  AWS_ACCESS_KEY_ID (Secret)
-  AWS_SECRET_ACCESS_KEY (Secret)
-  CORTEX_API_KEY (Secret)
-  CORTEX_API_KEY_ID (Secret)
-  AWS_REGION (Variable)
-  S3_BACKEND (Variable)

---

## Repository Structure

.
├── .github/
│   └── workflows/
│       └── xsiam-lab.yaml
├── infra/
│   ├── files/
│   ├── modules/
│   ├── 0_network.tf
│   ├── 1_jumpbox.tf
│   ├── 2_fw.tf
│   ├── 3_xsiam_components.tf
│   ├── 4_vms.tf
│   ├── backend.tf
│   ├── configuration.json
│   ├── data_sources.tf
│   ├── outputs.tf
│   ├── terraform.tfvars
│   ├── variables.tf
│   └── versions.tf
├── .gitignore
└── README.md

## Variables

Defined in **infra/terraform.tfvars**, you need to change them:

region      = "us-east-2"
name_prefix = "davila-xsiam-lab"

global_tags = {
  ManagedBy   = "terraform"
  Application = "XSIAM Lab"
  Owner       = "David Avila"
}

ssh_key_name = "xsiam-lab-v2"

### VPC

cidr           = "10.10.0.0/16"
mgt_public_ips = ["YOUR PUBLIC IP ADDRESS"]

### XSIAM Components

broker_vm        = false
broker_vm_key    = ""
broker_vm_subnet = "vlan1" # allowed values vlan1, vlan2. vlan1 by default

engine_vm        = false
engine_vm_subnet = "vlan1" # allowed values vlan1, vlan2. vlan1 by default

### Deploy VMs

linux_deploy          = true
windows_server_deploy = true
kali_deploy           = true


## Security

Do not commit .pem files
Do not hardcode credentials
Prefer IAM roles over static keys
Rotate credentials regularly