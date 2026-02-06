output "web_ips" {
  value = aws_instance.web[*].public_ip
}

output "alb_dns" {
  value = aws_lb.alb.dns_name
}
