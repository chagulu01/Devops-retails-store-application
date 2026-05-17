# output block

output "vpc_id" {
  value       = aws_vpc.dev-vpc.id
  description = "The ID of create VPC"

}

output "public_subnet_ids_map" {
  value       = { for az, subnet in aws_subnet.public : az => subnet.id }
  description = "Map of AZ to Public Subnet ID"
}


output "private_subnet_ids_map" {
  value       = { for az, subnet in aws_subnet.private : az => subnet.id }
  description = "Map of AZ to Private Subnet ID"
}