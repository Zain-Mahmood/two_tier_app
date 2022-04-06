provider "aws"{
    region = "eu-west-1"
}


resource "aws_vpc" "devops106_zmahmood_terraform_vpc_tf"{
    cidr_block = "10.201.0.0/16" 
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


resource "aws_instance" "devops106_terraform_zmahmood_webserver_app_tf" {
    ami = "ami-08ca3fed11864d6bb"
    instance_type = "t2.micro"
    key_name = "devops106_zmahmood"
    vpc_security_group_ids = [aws_security_group.devops106_terraform_zmahmood_sg_app_webserver_tf.id]

    subnet_id = aws_subnet.devops106_zmahmood_terraform_subnet_app_webserver_tf.id
    associate_public_ip_address = true

    tags ={
        Name ="devops106_terraform_zmahmood_app_webserver"
    }

    connection {
        type = "ssh"
        user = "ubuntu"
        host = self.public_ip
        private_key = file("/Users/Zain/Downloads/devops106_zmahmood.pem")
    }

    provisioner "local-exec" {
        command = "echo mongodb://${aws_instance.devops106_terraform_zmahmood_webserver_db_tf.public_ip}:27017 > database.config"
    }

    provisioner "file" {
        source      = "${path.cwd}/config/database.config"#
        destination = "/home/ubuntu/database.config"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo apt-get remove -y docker docker-engine docker.io containerd runc",
            "sudo apt-get update",
            "sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release",
            "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
            "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
            "sudo apt-get update",
            "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",
            "sudo usermod -a -G docker ubuntu"
        ]
    }

    provisioner "remote-exec" {
        inline = [
            "docker run -d -p 5000:5000 -v /home/ubuntu/database.config:/database.config leiungureanu/spartan_project_vagrant:1.2"
        ]
    }
}

resource "aws_instance" "devops106_terraform_zmahmood_webserver_db_tf" {
    ami                    = "ami-08ca3fed11864d6bb"
    instance_type          = "t2.micro"
    key_name               = "devops106_zmahmood"
    vpc_security_group_ids = [aws_security_group.devops106_terraform_zmahmood_sg_db_webserver_tf.id]

    subnet_id                   = aws_subnet.devops106_zmahmood_terraform_subnet_db_webserver_tf.id
    associate_public_ip_address = true

    tags = {
        Name = "devops106_terraform_zmahmood_db_webserver"
    }

    connection {
        type        = "ssh"
        user        = "ubuntu"
        host        = self.public_ip
        private_key = file("/Users/Zain/Downloads/devops106_zmahmood.pem")
    }

    provisioner "remote-exec" {
    inline = [
      "curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -",
      "echo \"deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse\" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list",
      "sudo apt update",
      "sudo apt install -y mongodb-org",
      "sudo systemctl start mongod.service",
      "sudo systemctl enable mongod",
      "sudo sed -i \"s/bindIp: 127.0.0.1/bindIp: 0.0.0.0/\" /etc/mongod.conf",
      "sudo systemctl restart mongod.service",
    ]

  }

}


# resource "aws_route53_zone" "devops106_terraform_zmahmood_dns_db_tf" {
#     name = "zmahmood.devops106"

#     vpc {
#       vpc_id = "vpc-05e060b2fb9707bc8"
#     }
# }
# resource "aws_route53_record" "devops106_terraform_zmahmood_dns_db_tf" {
#     zone_id = aws_route53_zone.devops106_terraform_zmahmood_dns_db_tf.zone_id
#     name = "db"
#     type = "A"
#     ttl = "30"
#     records = [aws_instance.devops106_terraform_zmahmood_webserver_db_tf.public_ip]
# }