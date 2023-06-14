output "public_ip" {
  value = aws_instance.jenkins_server.public_ip 
  description = "ec2 instance public-ip"
}