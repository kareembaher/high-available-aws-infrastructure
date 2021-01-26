/*App EC2 Instance*/
resource "aws_instance" "app-eu1-ec2-1" {
  ami                     = data.aws_ami.ami-amazon-linux-2.id
  instance_type           = "t3.small"
  key_name                = "EU1-KP"
  vpc_security_group_ids  = [aws_security_group.app-SG.id]
  disable_api_termination = "true"

  root_block_device {
    delete_on_termination = true
    volume_size           = "50"
    volume_type           = "standard"
  }

  tags = {
    Name        = "app-eu1-ec2-1"
  }
  subnet_id                   = aws_subnet.EU1-Pub1.id
  tenancy                     = "default"
  associate_public_ip_address = true
  lifecycle {
    ignore_changes = [user_data, ami]
  }
  user_data = <<EOF
    #!/bin/bash
    HOSTNAME=app-eu1-1
    echo "127.0.0.1   $HOSTNAME localhost localhost.localdomain" > /etc/hosts
    sed -i -e "s/HOSTNAME=localhost.localdomain/HOSTNAME=$HOSTNAME/" /etc/sysconfig/network
    hostname -F /etc/hostname
    service network restart
    MOUNT_TARGET="/mnt/efs/"
    mkdir -p $MOUNT_TARGET
    yum -y install nfs-utils
    echo 'fs-0769a6cd.efs.eu-west-1.amazonaws.com:/ /mnt/efs/ nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0' >> /etc/fstab
    /bin/mount -a
EOF
}