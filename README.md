
# Cloud Definitions Project

This project sets up an AWS-based application that retrieves and displays random cloud-related definitions from a DynamoDB database. The project uses AWS Lambda for fetching data, API Gateway for API endpoints, DynamoDB for storing cloud definitions, and S3 for hosting static websites.

## Features

- **Lambda Function**: Randomly fetches a cloud computing definition from DynamoDB and returns it via API Gateway.
- **API Gateway**: Exposes an HTTP endpoint to trigger the Lambda function.
- **DynamoDB**: Stores cloud-related definitions in the `CloudDefinitions` table.
- **S3 Static Website**: Hosts an HTML page to display the random cloud definition.

## Architecture

- **Lambda Function**: A Python-based function that fetches data from DynamoDB and serves it via API Gateway.
- **DynamoDB**: A table storing cloud-related definitions.
- **API Gateway**: Exposes an endpoint for retrieving definitions.
- **S3**: Hosts the `index.html` file, which makes the request to the Lambda function.
- **EC2 Instance**: Automatically provisions a worker EC2 instance to upload the necessary data to DynamoDB and manage other infrastructure.

## Getting Started

Follow the steps below to get this project running in your AWS environment.

### Prerequisites

- AWS account
- Terraform installed
- AWS CLI configured
- An S3 bucket for remote state management (optional)

### Setup

1. **Clone the Repository**

   Clone this repository to your local machine:

   ```bash
   git clone https://github.com/username/repository.git
   cd repository
   ```

2. **Configure AWS Credentials**

   Ensure your AWS credentials are set up properly on your local machine using the AWS CLI:

   ```bash
   aws configure
   ```

3. **Run Terraform**

   Initialize and apply Terraform to provision the necessary AWS resources.

   ```bash
   terraform init
   terraform apply
   ```

   This will set up:
   - **DynamoDB Table** (`CloudDefinitions`)
   - **Lambda Function**
   - **API Gateway Endpoint**
   - **S3 Buckets** for static website and Lambda code storage
   - **EC2 Instance** to upload data to DynamoDB

4. **Deploy Lambda Function Code**

   Ensure your Lambda function code is uploaded to S3, and the Lambda function is linked to the API Gateway.

5. **Deploy Static Website**

   The `index.html` will be automatically uploaded to S3 and will be accessible via the following URL (replace with actual URL from your S3 bucket):

   ```bash
   http://<S3_BUCKET_NAME>.s3-website-<REGION>.amazonaws.com
   ```

   This will display the cloud definitions on the webpage.

### Files Overview

- `data.json`: Contains the list of cloud definitions stored in DynamoDB.
- `index.html`: A static HTML page that fetches random cloud definitions from the API.
- `lambda_function.py`: Python script that fetches a random cloud definition from DynamoDB and returns it via API Gateway.
- `apiGateWay.tf`: Terraform configuration for setting up API Gateway.
- `dynamodb.tf`: Terraform configuration for setting up DynamoDB.
- `ec2.tf`: Terraform configuration for provisioning an EC2 instance.
- `iam.tf`: IAM roles and policies for Lambda and EC2 access.
- `lambda.tf`: Lambda function setup using Terraform.
- `provider.tf`: AWS provider configuration for Terraform.
- `s3.tf`: Terraform configuration for setting up S3 buckets.
- `sg.tf`: Security groups for EC2 access.
- `userData.sh`: Script for provisioning EC2 instance, cloning the repository, and uploading Lambda code.

### Usage

Once everything is set up:

- Access the static website via S3 URL. It will show a random cloud computing definition fetched from DynamoDB.
- Click "Get Another Definition" to fetch another definition.

### Notes

- Modify the `index.html` file and Lambda function code for additional customizations.
- You can add more definitions to `data.json` to expand the range of cloud terms available.

### Cleaning Up

To remove all resources created by this project:

1. Run `terraform refresh` to make sure terraform state has the most up to date configuration
1. Run `terraform destroy` to delete the provisioned infrastructure.

```bash
terraform refresh
terraform destroy
```

This will delete all AWS resources, including the EC2 instance, DynamoDB table, Lambda function, and S3 buckets.
