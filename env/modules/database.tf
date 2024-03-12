/*
resource "aws_security_group" "rds-sg" {
  name        = "rds-security-group"
  description = "Allow MY IP inbound traffic"
  vpc_id      = "vpc-035421cb609afc552"

#INBOUND RULE
  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.myip]
    #ipv6_cidr_blocks = [var.myip]
  }
  ingress {
    description      = "TCP from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = [var.myip]
    #ipv6_cidr_blocks = [var.myip]
  }
  ingress {
    description      = "TCP from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = [aws_security_group.airflow-sd.id]
    #ipv6_cidr_blocks = [var.myip]
  }



#OUTBOUND RULE 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "airflow-security-group"
  }
}
*/