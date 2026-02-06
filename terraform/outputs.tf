output "web_public_ips" {
  description = "Public IPs of web EC2 instances"
  value       = aws_instance.web[*].public_ip
}
