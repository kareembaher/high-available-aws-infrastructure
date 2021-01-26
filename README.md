# small-high-available-aws-infrastructure
 
Hello,

This repo will help you create a small High available AWS cloud infrastructure using Terraform.

## Description
If you for example have a web application or web site, and you want to host it on a high available infrastructure, this is the right repo for you.

You will have 2 EC2 instances that will act as you application servers to host your application or website on it.
So, you will have to install your web server for example on these application servers, these servers are load balanced with an ALB.

Also, you will find a 3rd EC2 instance, I named it Utilities, where its purpose is to install your monitoring and alerting tools on it, or if you want to setup a CI/CD pipeline on it.

You will find a Postgres RDS for your data storage.

You will also find a shared storage between the 2 application EC2s, so you can configure the logs or configuration files in it.

Furthermore, I configured to import a SSL certificate to secure your application, of coarse you will need to buy a certificate from a certificate provider (for example AWS or Godaddy) and put the files in `ssl` directory provided in the repo.

All these services are hosted on a separate VPC from the default one, where the application servers are on a public subnets and the DB on a private subnet.

## What will be built and deployed?
You will find 13 .tf files that will deploy:
- VPC
- 2 public and 2 private subnets
- Public and private routes
- Internet Gateway (IGW) and NAT Gateway (NATGW)
- 3 EC2 instances
- Application Load Balancer (ALB)
- Shared storage EFS
- Postgres DB RDS
- Security Group for each resource
- Importing SSL certificate using ACM service

## Prerequisites
You will need to install the following:
#### AWS Account
- You have to create an AWS account in order to deploy your infrastructure on it.
- To signup, please use this URL https://portal.aws.amazon.com/billing/signup#/start
- IMPORTANT: Please make sure to save your .csv file when you created your user that you will find in it an access key and secret access key for later use.

#### AWS CLI version 2
- You need to install AWS CLI on your mchine, in order to signin to your ccount from your machine terminal and execute AWS commands to build your infrastructure
- To install AWS2 CLI, please refer to this URL https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html

#### Terraform
- This is the tool that we will use to deploy our infrastructure
- To install Terraform, please refer to this URL https://learn.hashicorp.com/tutorials/terraform/install-cli

#### Create a SSH key in AWS console
- You will have to create an SSH key in order to access your servers.
- So, follow these steps to create the SSH key:

1- Go to your AWS console.

2- Select the Region where you will deploy your infrastructre from the upper right part next to your username.

3- In the search, type EC2, then click on it.

4- In the left panel, click `Key Pairs` in `Network & Security` section.

5- On the top right section, click `Create Key Pair`.

6- Type a name for your Key Pair, prefered to be `EU1-KP` to match the info configured in the .tf files I made.

7- Click `Create Key Pair`.

8- Download the file to use it to SSH to your servers.

## How to use?
- If you are going to use SSL certificate, please put your files in `ssl` directory, then change the names of these files in `acm.tf` file. And if you are not going to import SSL certificates, please delete or disable this file.
- First you will need to setup your AWS credentials through AWS CLI, so execute the following command:
```
aws configure
```
you will be prompted to enter some info; you will fill this info from the .csv file of your AWS account you saved earlier.

- Next, we will execute our terraform commands to deploy our infrastructure
Go to the directory or folder where you have the Terraform files and execute:
```
terraform init
```
then
```
terraform apply
```
you will be prompted to answer with yes or no, please type yes and press enter.

It may take some time for the infrastructure to be deployed.

After it is finished, you may go and check the environment on AWS console.