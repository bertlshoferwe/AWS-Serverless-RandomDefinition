resource "aws_iam_role" "lambda_dynamodb_role" {
  name = "lambda_dynamodb_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Service : "lambda.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name        = "lambda_dynamodb_policy"
  description = "Policy for Lambda to access DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:BatchWriteItem"
        ],
        Resource : "arn:aws:dynamodb:*:*:table/CloudDefinitions"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_attachment" {
  role       = aws_iam_role.lambda_dynamodb_role.name
  policy_arn = aws_iam_policy.lambda_dynamodb_policy.arn
}


# Give EC2 ability to shut down from cli
resource "aws_iam_role" "ec2_role" {
  name = "ec2-shutdown-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "ec2_stop_policy" {
  role = aws_iam_role.ec2_role.name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = ["ec2:StopInstances",
        "ec2:DescribeInstances",
        "AmazonS3FullAccess",
        "EC2FullAccess"
      ],
      Effect   = "Allow",
      Resource = "*"
    }]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-shutdown-profile"
  role = aws_iam_role.ec2_role.name
}