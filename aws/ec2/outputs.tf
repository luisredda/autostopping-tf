output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.ec2.*.public_ip
}

output "id" {
  description = "List of IDs of instances"
  value       = aws_instance.ec2.*.id
}
