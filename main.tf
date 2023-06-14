resource "aws_instance" "jenkins_server" {
  ami           = "ami-07fb9d5c721566c65"
  instance_type = "t2.medium"
  key_name      = "realmen12345"
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum install wget git vim -y
              sudo wget -O /etc/yum.repos.d/jenkins.repo \
                  https://pkg.jenkins.io/redhat-stable/jenkins.repo
              sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
              sudo yum upgrade -y
              sudo yum install -y java-11-openjdk
              sudo yum install -y jenkins
              sudo systemctl daemon-reload
              sudo systemctl enable jenkins
              sudo systemctl start jenkins
              sudo systemctl status jenkins
              sudo cat /var/lib/jenkins/secrets/initialAdminPassword
              EOF

  tags = {
    Name = "Jenkins"
  }
}
