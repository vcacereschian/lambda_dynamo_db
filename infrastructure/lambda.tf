data "archive_file" "create-note-archive" {
 source_file = "lambdas/create_note.py"
 output_path = "lambdas/create_note.zip"
 type = "zip"
}



resource "aws_lambda_function" "create-note" {
 environment {
   variables = {
     NOTES_TABLE = aws_dynamodb_table.tf_notes_table.name,
     REGION = var.aws_region
   }

 }
 memory_size = "128"
 timeout = 10
 runtime = "python3.10"
 architectures = ["arm64"]
 handler = "create_note.lambda_handler"
 function_name = var.user_name 
 role = aws_iam_role.iam_for_lambda.arn
 filename = "lambdas/create_note.zip"

  tags = {
    Name   = var.user_name,
    project = var.project,
    user = var.user,
    validity = var.validity

  }
}

resource "aws_lambda_function_url" "test_latest" {
  function_name      = aws_lambda_function.create-note.function_name
  authorization_type = "NONE"

cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }




}

output "lambda_function_url" {
  value = aws_lambda_function_url.test_latest.function_url
}
