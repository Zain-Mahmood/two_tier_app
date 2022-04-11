provider "aws"{
    region = "eu-west-1"
}


resource "aws_vpc" "devops106_zmahmood_terraform_vpc_tf"{
    cidr_block = "10.201.0.0/16" 
    
    enable_dns_support = true
    enable_dns_hostnames = true
    
    tags ={
        Name = "devops106_zmahmood_terraform_vpc"
    }
}


resource "aws_subnet" "devops106_zmahmood_terraform_subnet_app_webserver_tf"{
    vpc_id = aws_vpc.devops106_zmahmood_terraform_vpc_tf.id
    cidr_block = "10.201.1.0/24" 
    tags ={
        Name = "devops106_zmahmood_app_subnet"
    }
}


resource "aws_subnet" "devops106_zmahmood_terraform_subnet_db_webserver_tf"{
    vpc_id = aws_vpc.devops106_zmahmood_terraform_vpc_tf.id
    cidr_block = "10.201.2.0/24" 
    tags ={
    Name = "devops106_zmahmood_db_subnet"
    }
}


resource "aws_internet_gateway" "devops106_zmahmood_terraform_ig_tf"{
    vpc_id = aws_vpc.devops106_zmahmood_terraform_vpc_tf.id
    tags = {
    Name = "devops106_zmahmood_terraform_ig"
    }
}


resource "aws_route_table" "devops106_zmahmood_terraform_rt_public_tf"{
    vpc_id = aws_vpc.devops106_zmahmood_terraform_vpc_tf.id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.devops106_zmahmood_terraform_ig_tf.id

    }

    tags = {
        Name = "devops106_zmahmood_terraform_rt_public"
    }
}


resource "aws_route_table_association" "devops106_zmahmood_terraform_rt_assoc_app_public_webserver_tf"{
    subnet_id = aws_subnet.devops106_zmahmood_terraform_subnet_app_webserver_tf.id
    route_table_id = aws_route_table.devops106_zmahmood_terraform_rt_public_tf.id
}

resource "aws_route_table_association" "devops106_zmahmood_terraform_rt_assoc_db_public_webserver_tf"{
    subnet_id = aws_subnet.devops106_zmahmood_terraform_subnet_db_webserver_tf.id
    route_table_id = aws_route_table.devops106_zmahmood_terraform_rt_public_tf.id
}


resource "aws_network_acl" "devops106_zmahmood_terraform_nacl_app_public_tf"{
    vpc_id = aws_vpc.devops106_zmahmood_terraform_vpc_tf.id

    ingress {
        rule_no = 100
        from_port = 22
        to_port = 22
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    ingress {
        rule_no = 200
        from_port = 27017
        to_port = 27017
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    ingress {
        rule_no = 10000
        from_port = 1024
        to_port = 65535
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }


    egress {
        rule_no = 100
        from_port = 80
        to_port = 80
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    egress {
        rule_no = 200
        from_port = 443
        to_port = 443
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    egress {
        rule_no = 10000
        from_port = 1024
        to_port = 65535
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    subnet_ids = [aws_subnet.devops106_zmahmood_terraform_subnet_app_webserver_tf.id]

    tags={
        Name = "devops106_zmahmood_terraform_nacl_app_public"
    }
}

resource "aws_network_acl" "devops106_zmahmood_terraform_nacl_public_db_tf"{
    vpc_id = aws_vpc.devops106_zmahmood_terraform_vpc_tf.id

    ingress {
        rule_no = 100
        from_port = 22
        to_port = 22
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    ingress {
        rule_no = 200
        from_port = 27017
        to_port = 27017
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    ingress {
        rule_no =10000
        from_port = 1024
        to_port = 65535
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    egress {
        rule_no =100
        from_port = 80
        to_port = 80
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    egress{
        rule_no =200
        from_port = 443
        to_port = 443
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }

    egress{
        rule_no =10000
        from_port = 1024
        to_port = 65535
        cidr_block = "0.0.0.0/0"
        protocol = "tcp"
        action = "allow"
    }
    subnet_ids = [aws_subnet.devops106_zmahmood_terraform_subnet_db_webserver_tf.id]

    tags={
        Name = "devops106_zmahmood_terraform_nacl_db_public"
    }
}


resource "aws_security_group" "devops106_terraform_zmahmood_sg_app_webserver_tf"{
    name = "devops106_terraform_zmahmood_app_sg"
    vpc_id = aws_vpc.devops106_zmahmood_terraform_vpc_tf.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress{
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
  

  tags ={
    Name = "devops106_zmahmood_terraform_sg_app_webserver"
  }
}


resource "aws_security_group" "devops106_terraform_zmahmood_sg_db_webserver_tf"{
    name = "devops106_terraform_zmahmood__db_sg"
    vpc_id = aws_vpc.devops106_zmahmood_terraform_vpc_tf.id

    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress{
        from_port = 27017
        to_port = 27017
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags ={
    Name = "devops106_terraform_zmahmood_sg_db_webserver"
    }
}

data "template_file" "app_init" {
    template = file("../init-scripts/docker-install.sh")
}

data "template_file" "db_init" {
    template = file("../init-scripts/mongodb-install.sh")
}


resource "aws_instance" "devops106_terraform_zmahmood_webserver_app_tf" {
    ami = "ami-08ca3fed11864d6bb"
    instance_type = "t2.micro"
    key_name = "devops106_zmahmood"
    vpc_security_group_ids = [aws_security_group.devops106_terraform_zmahmood_sg_app_webserver_tf.id]

    subnet_id = aws_subnet.devops106_zmahmood_terraform_subnet_app_webserver_tf.id
    associate_public_ip_address = true

    # user_data = data.template_file.app_init.rendered
    count = 3
    tags ={
        Name ="devops106_terraform_zmahmood_app_webserver"
    }

    connection {
        type = "ssh"
        user = "ubuntu"
        host = self.public_ip
        # private_key = file("/home/vagrant/.ssh/devops106_zmahmood.pem")
        private_key = file("/Users/Zain/Downloads/devops106_zmahmood.pem")
    }


    # provisioner "local-exec" {
    #     command = "echo mongodb://${aws_instance.devops106_terraform_zmahmood_webserver_db_tf.public_ip}:27017 > config/database.config"
    # }

    provisioner "file" {
        source      = "${path.cwd}/config/database.config"
        destination = "/home/ubuntu/database.config"
    }
    
    provisioner "local-exec" {
        command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${self.public_ip},' -u ubuntu --private-key /Users/Zain/Downloads/devops106_zmahmood.pem ../ansible/docker-playbook.yml"
    }

    
    # provisioner "file" {
    #     source = "../init-scripts/docker-install.sh"
    #     destination = "/home/ubuntu/docker-install.sh"
      
    # }
    # provisioner "remote-exec" {
    #     inline = [
    #         "bash /home/ubuntu/docker-install.sh"

    #     ]
    # }

    # provisioner "remote-exec" {
    #     inline = [
    #         "docker run -d -p 5000:5000 -v /home/ubuntu/database.config:/database.config zainmahmood/group4:v1"
    #     ]
    # }

}

resource "aws_instance" "devops106_terraform_zmahmood_webserver_db_tf" {
    ami                    = "ami-08ca3fed11864d6bb"
    instance_type          = "t2.micro"
    key_name               = "devops106_zmahmood"
    vpc_security_group_ids = [aws_security_group.devops106_terraform_zmahmood_sg_db_webserver_tf.id]

    subnet_id                   = aws_subnet.devops106_zmahmood_terraform_subnet_db_webserver_tf.id
    associate_public_ip_address = true

    user_data = data.template_file.db_init.rendered

    tags = {
        Name = "devops106_terraform_zmahmood_db_webserver"
    }

    
    connection {
        type        = "ssh"
        user        = "ubuntu"
        host        = self.public_ip
        private_key = file("/Users/Zain/Downloads/devops106_zmahmood.pem")
        # private_key = file("/home/vagrant/.ssh/devops106_zmahmood.pem")
    }


#     provisioner "file" {
#         source = "../init-scripts/mongodb-install.sh"
#         destination = "/home/ubuntu/mongodb-install.sh"
      
#     }
     
#      provisioner "remote-exec" {
#      inline = [
#          "bash /home/ubuntu/mongodb-install.sh"
#     ]

#    }
}


resource "aws_route53_zone" "devops106_terraform_zmahmood_dns_zone_tf" {
     name = "zmahmood.devops106"

     vpc {
       vpc_id = aws_vpc.devops106_zmahmood_terraform_vpc_tf.id
     }
   
 }



resource "aws_route53_record" "devops106_terraform_zmahmood_dns_db_tf" {
    zone_id = aws_route53_zone.devops106_terraform_zmahmood_dns_zone_tf.zone_id
    name = "db"
    type = "A"
    ttl = 30
    records = [aws_instance.devops106_terraform_zmahmood_webserver_db_tf.public_ip]
}

