#NAMING
locals {
aws_prefix = "aws-${substr(var.region,0,2)}-${substr(var.environment,0,1)}-${var.application}"
#aws-eu-west2-airflow
}

#KEY-PAIR
resource "aws_key_pair" "instance-key" {
  key_name = "${local.aws_prefix}-keys"
  public_key = var.public-key
}

#ADDITIONAL DISK CREATION 
resource "aws_ebs_volume" "additional-disk" {
  availability_zone = var.zone
  size              = var.add-disk-size

  tags = {
    Name = "${local.aws_prefix}-ini-additional-disk"
  }
}


#SNAPSHOT 
/*resource "aws_ebs_snapshot" "add_snapshot" {
  volume_id = aws_ebs_volume.additional-disk.id

  tags = {
    Name = "${local.aws_prefix}-additional-disk-snapshot"
    Application = var.application
  }
}*/


#LAUNCH TEMPLATE
resource "aws_launch_template" "linux" {
    #count = var.linux ? 1 : 0
    name = "${local.aws_prefix}-linux-machine-templates"
    instance_type = var.instance-type #t2.micro
    key_name = aws_key_pair.instance-key.key_name
    image_id = var.image-id
    vpc_security_group_ids = [aws_security_group.instance-sg.id]
    
    #BOOT DISK
    block_device_mappings {
      device_name = "/dev/sdb"
    ebs {
        volume_size = var.boot-disk-size                      #10
        delete_on_termination = true
        volume_type = var.volume-type                         #STANDARD
        }
    }
   
    #ADDITIONAL DISK
    /*block_device_mappings {
      device_name = "/dev/sdc"
    ebs {
        volume_size = var.add-disk-size                        #10
        delete_on_termination = true
        volume_type = var.volume-type
        snapshot_id = aws_ebs_snapshot.add_snapshot.id
        }
    }*/
    monitoring {
        enabled = true
    }
    placement {
        availability_zone = var.zone
    }
    tag_specifications {
        resource_type = "instance"
        tags = {
        Name = "${local.aws_prefix}"
        script = "${var.application}-init"
        image   = var.image_name
        }
    }
    user_data = var.init-script
    #aws_launch_template.linux.tag_specifications.tags.scrit.value
}


#LAUNCHING THE INSTANCE USING THE TEMPLATE
resource "aws_instance" "instance-dev" {
  #ami                     = var.image-id
  #instance_type           = "m5.large"
  #host_resource_group_arn = "arn:aws:resource-groups:us-west-2:012345678901:group/win-testhost"
  #tenancy                 = "host"
  count = 1
  launch_template {
    name = aws_launch_template.linux.name
    #id  = aws_launch_template.linux.id
  } 
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = var.private-key
      timeout     = "4m"
   }
  tags = {
    Name = "${local.aws_prefix}-instance-${count.index}"
    #Script = var.source_script
  }

  /*provisioner "file" {
    source =  "../scripts/airflow-init.sh"
    destination = "/tmp/airflow-init.sh"
  }

  provisioner "remote-exec" {
  #command = "echo aws_instance.airflow-dev.public_ip >> public_ips.txt"
  inline =[
    "chmod u+x /tmp/airflow-init.sh",
    "sudo /tmp/airflow-init.sh"
  ]
}*/

}
