#!/bin/bash

# Install needed dependencys
sudo yum update -y
sudo yum install -y git awscli curl

# Setting variables for ec2
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)

# Create directories
mkdir lambda

# Clone the GitHub repository copy needed files to lambda directory
git clone https://github.com/username/repository.git /home/ec2-user/repository
cp /function_workspace/lambda_function.py /lambda

#upload index.html to static web bucket
aws s3 cp /function_workspace/index.html s3://Random-gen-web

# zip and upload lambda files
cd lambda
zip -r ../my-deployment-package.zip .
aws s3 cp my-deployment-package.zip s3://code-storage

# Shut down instance as no longer needed
aws ec2 stop-instances --instance-ids $INSTANCE_ID --region $REGION