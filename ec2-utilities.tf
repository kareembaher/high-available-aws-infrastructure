/*Jenkins EC2 Instance*/
resource "aws_instance" "utilities-eu1-ec2" {
  ami                     = data.aws_ami.ami-amazon-linux-2.id
  instance_type           = "t3.small"
  key_name                = "EU1-KP"
  vpc_security_group_ids  = [aws_security_group.Utilities-SG.id]
  disable_api_termination = "true"
  ebs_optimized           = true

  root_block_device {
    delete_on_termination = true
    volume_size           = "20"
    volume_type           = "standard"
  }
  tags = {
    Name        = "Utilities-eu1-ec2"
  }
  subnet_id                   = aws_subnet.EU1-Pub1.id
  tenancy                     = "default"
  associate_public_ip_address = true
  lifecycle {
    ignore_changes = [user_data, ami]
  }
  user_data = <<EOF
    #!/bin/bash
    HOSTNAME=utilities-eu1
    echo "127.0.0.1   $HOSTNAME localhost localhost.localdomain" > /etc/hosts
    sed -i -e "s/HOSTNAME=localhost.localdomain/HOSTNAME=$HOSTNAME/" /etc/sysconfig/network
    hostname -F /etc/hostname
    service network restart
    yum update -y
    amazon-linux-extras install docker
    service docker enable
    service docker start
    usermod -a -G docker ec2-user
    EOF
}