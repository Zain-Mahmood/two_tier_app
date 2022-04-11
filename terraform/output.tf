output "webservers_ip_addresses_output" {
    value = aws_instance.devops106_terraform_zmahmood_webserver_app_tf[*].public_ip
}

output "database_ip_addresses_output" {
    value = aws_instance.devops106_terraform_zmahmood_webserver_db_tf[*].public_ip
}

