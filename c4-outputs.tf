# output block

output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket

}

output "s3_bucket_id" {
  value = aws_s3_bucket.my_bucket.id

}

output "s3_bucket_arn" {
  value = aws_s3_bucket.my_bucket.arn
}

output "vpc_id1" {
  value       = module.vpc.vpc_id
  description = "The ID of create VPC"

}

output "public_subnet_ids_map1" {
  value       = module.vpc.public_subnet_ids_map
  description = "Map of AZ to Public Subnet ID"
}


output "private_subnet_ids_map1" {
  value       = module.vpc.private_subnet_ids_map
  description = "Map of AZ to Private Subnet ID"
}