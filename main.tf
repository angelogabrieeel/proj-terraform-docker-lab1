provider "aws" {
  region = "us-east-1"
}

# Tabelas DynamoDB
resource "aws_dynamodb_table" "lab1_products" {
  name           = "lab1-products"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
attribute {
    name = "id"
    type = "S"
  }
}
resource "aws_dynamodb_table" "lab1_orders" {
  name           = "lab1-orders"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
attribute {
    name = "id"
    type = "S"
  }
}
resource "aws_dynamodb_table" "lab1_tickets" {
  name           = "lab1-tickets"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
attribute {
    name = "id"
    type = "S"
  }
}
