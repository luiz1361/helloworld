# Helloworld
![Docker Build](https://img.shields.io/docker/cloud/build/luiz1361/helloworld.svg)
![Docker Automated Build](https://img.shields.io/docker/cloud/automated/luiz1361/helloworld.svg)
![Github Last-Commit](https://img.shields.io/github/last-commit/luiz1361/helloworld.svg)
![License: GPL v3+](https://img.shields.io/badge/License-GPL%20v3%2B-blue.svg)

---

**Helloworld** was created as a personal playground for IaC, Automation, Cloud, Monitoring, Build Pipelines, etc...

The main goal is to build a highly scalable Wordpress(LAMP) application based on the following CI/CD stack as much as code as possible.

Restrictions & Observations: 
* A key restrictions for this project is to be a zero or near zero cost under AWS free-tier limits and/or Azure 12-months trial
* Be easy to get started, develop, deploy and maintain leveraging open source projects

Future plans: 
* Might add a second cloud provider as Azure for multi region hybrid cloud environment
* Separate Staging / Production environments 

Planned CI/CD stack:
* IaC and Config Management:
  * Terraform
  * Ansible 
* Infrastructure:
  * AWS:
    * EC2
    * ELB
    * ASG
    * EFS
    * IAM
    * S3
    * RDS
    * SES
    * Alexa
    * Lambda
    * DynamoDB
    * API Gateway
    * SQS
    * Cloud Watch
    * VPC
  * Cloudflare:
    * DNS
    * CDN
* Project/Code repository:
  * Github
* Docker image registry and automated tests:
  * DockerHub
* Code quality:
  * Codacy
* Container:
  * Orquestration:
    * Swarm Mode
  * Management:
    * Portainer
  * Reverse proxy/load balancer:
    * Traefik
* Monitoring:
  * Prometheus
    * Alertmanager
  * Netdata
  * Grafana
* IM:
  * Slack
* Application:
  * Wordpress(LAMP)

More cool things to add in the future as time allows.

---

## Prerequisites:
* AWS Account with programmatic access and administrative permissions to create, edit and remove resources.
* Cloudflare Account with API access and administrative permissions to create, edit and remove resources.
* DockerHub Account with administrative permissions to create, edit and remove resources.
* GitHub Account with administrative permissions to create, edit and remove resources.
* AWS-Nuke Binary(https://github.com/rebuy-de/aws-nuke/releases) installed.
* Terraform Binary(https://www.terraform.io/downloads.html) installed.

### Manual tasks(still out of IaC):

#### AWS:
* Initial CloudWatch billing alert via SNS to avoid surprises =)
* User terraform with AdministratorAccess.
* Account alias configured as required by AWS-Nuke ie. aws iam create-account-alias.

#### Cloudflare:
* Registrar domain registration.
* Retrieve API user credentials.

#### DockerHub:
* Create image repository.
* Configure auto build and test.
* Integrate hooks with Github and Slack.

#### GitHub:
* Create source code repository.
* Integrate hooks with Slack.

### Credentials export:

The following variables need to be exported to the current environment:
```
export AWS_ACCESS_KEY_ID=xxx
export AWS_SECRET_ACCESS_KEY=xxx
export CLOUDFLARE_EMAIL=xxx@xxx.xxx
export CLOUDFLARE_TOKEN=xxx
export TF_VAR_rds_username=xxx
export TF_VAR_rds_password=xxx

```

## Getting started:

### Purge your AWS account to bare bones(Run whenever needed):
```aws-nuke -c aws-nuke/config.yaml --profile default --no-dry-run```

The command above will purge the whole AWS account leaving just the stuff filtered on config.yaml. That is to make sure the account is clean even when things are done out(drift) of Terraform ie. AWS Console, AWS CLI, Cloudflare API, Cloudflare Console, etc.

### Deployment:

#### Required during first time run:

```
cd terraform
terraform init
```

The command above will initialize Terraform, downloading any required modules ie. AWS, Cloudflare, etc.

#### Now for future runs:

```
cd terraform
terraform plan -out /tmp/tfplan
terraform apply /tmp/tfplan
```

The first command above will plan the Terraform deployment and describe the change. After that it will store it on -out location.
The second command will apply the planned changes as per -out location previous saved.

### Undeployment:

```
cd terraform
terraform destroy
```

The command above will destroy all infrastructure built via Terraform. **Might be a good idea to run aws-nuke to be sure no actions were performed out of Terraform to avoid any unexpected costs.**