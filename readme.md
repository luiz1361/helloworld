# Helloworld
![Docker Build](https://img.shields.io/docker/cloud/build/luiz1361/helloworld.svg)
![Docker Automated Build](https://img.shields.io/docker/cloud/automated/luiz1361/helloworld.svg)
![Github Last-Commit](https://img.shields.io/github/last-commit/luiz1361/helloworld.svg)
![License: GPL v3+](https://img.shields.io/badge/License-GPL%20v3%2B-blue.svg)

---

**Helloworld** was created as a personal playground for technologies such as Terraform, Cloudflare and Docker. 

More cool things to add in the future as time allows.

---

## Prerequisites
* AWS Account with programmatic access and administrative permissions to create, edit and remove resources.
* Cloudflare Account with API access and administrative permissions to create, edit and remove resources.
* AWS-Nuke Binary(https://github.com/rebuy-de/aws-nuke/releases)
* Terraform Binary(https://www.terraform.io/downloads.html)

### Credentials export

The following variables need to be exported to the current environment:
```
export AWS_ACCESS_KEY_ID=xxx
export AWS_SECRET_ACCESS_KEY=xxx
export CLOUDFLARE_EMAIL=xxx@xxx.xxx
export CLOUDFLARE_TOKEN=xxx
export TF_VAR_rds_username=xxx
export TF_VAR_rds_password=xxx

```

## Usage

### Nuke your AWS account to bare bones
```aws-nuke -c aws-nuke/config.yaml --profile default --no-dry-run```

The command above will purge the whole AWS account leaving just the stuff filtered on config.yaml. That is to make sure the account is clean even things are done ou(drift) of Terraform ie. AWS Console, AWS CLI, Cloudflare API, Cloudflare Console, etc.

### Deploy AWS Infrastructure via Terraform
```
cd terraform
terraform init
terraform plan -out /tmp/tplan
terraform apply /tmp/tplan
```

### Destroy AWS Infrastructure via Terraform
```
cd terraform
terraform destroy
```