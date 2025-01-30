sudo yum update -y

#Instale o yum-utils
sudo yum install -y yum-utils

#Adicionando o repositorio HashiCorp
sudo yum-config-manager --add-repo <https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo>

#Instale o Terraform
sudo yum -y install terraform

#Verifique se o Terraform foi instalado corretamente
terraform version
