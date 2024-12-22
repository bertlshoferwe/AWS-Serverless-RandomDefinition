module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name     = "CloudDefinitions"
  hash_key = "id"

  attributes = [
    {
      name = "id"
      type = "S"
    }
  ]

}

resource "null_resource" "upload_dynamodb_items" {
  provisioner "local-exec" {
    command = <<EOT
    aws dynamodb batch-write-item --request-items file://function_workspace/data.json
    EOT
  }

  triggers = {
    table_name = aws_dynamodb_table.CloudDefinitions.name
  }
}

