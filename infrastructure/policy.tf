resource "aws_iam_role" "iam_for_lambda" {
 name = "iam_for_lambda-${var.user_name}"

 assume_role_policy = jsonencode({
   "Version" : "2012-10-17",
   "Statement" : [
     {
       "Effect" : "Allow",
       "Principal" : {
         "Service" : "lambda.amazonaws.com"
       },
       "Action" : "sts:AssumeRole"
     }
   ]
  })
  tags = {
    Name   = var.user_name,
    project = var.project,
    user = var.user,
    validity = var.validity

  }
}
          
resource "aws_iam_role_policy_attachment" "lambda_policy" {
   role = aws_iam_role.iam_for_lambda.name
   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
          
resource "aws_iam_role_policy" "dynamodb-lambda-policy" {
   name = "dynamodb_lambda_policy"
   role = aws_iam_role.iam_for_lambda.id
   policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
           "Effect" : "Allow",
           "Action" : ["dynamodb:*", "dynamodb:PutItem"],
           "Resource" : "${aws_dynamodb_table.tf_notes_table.arn}"
        }
      ]
   })
}

