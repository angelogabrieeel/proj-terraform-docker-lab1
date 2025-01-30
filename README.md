## Subindo uma aplicação .json com backend e frontend, utilizando a EC2 AWS, Linux, Terraform e Docker.

Neste projeto, utilizei algumas ferramentas de DevOps, sendo elas:

### O portal da AWS:
* Para a criação da maquina virtual com um sistema Linux rodando nela.
* Instalar o Terraform no ambiente linux;
~~~sh
sudo yum update -y

#Instale o yum-utils
sudo yum install -y yum-utils

#Adicionando o repositorio HashiCorp
sudo yum-config-manager --add-repo <https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo>

#Instale o Terraform
sudo yum -y install terraform

#Verifique se o Terraform foi instalado corretamente
terraform version
~~~

* Instalar o Docker no ambiente linux;
~~~sh
#Instalar Docker na Maquina Virtual EC2
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo docker run hello-world
sudo systemctl enable docker
docker --version
sudo usermod -a -G docker $(whoami)
newgrp docker
~~~

### Terraform:
* Para a criação de tabelas em DynamoDB
~~~tf
provider "aws" {
  region = "us-east-1"
}

# Tabelas DynamoDB
resource "aws_dynamodb_table" "lab1_products" {
  name           = "lab1-products"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
attribute {
    name = "id"
    type = "S"
  }
}
resource "aws_dynamodb_table" "lab1_orders" {
  name           = "lab1-orders"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
attribute {
    name = "id"
    type = "S"
  }
}
resource "aws_dynamodb_table" "lab1_tickets" {
  name           = "lab1-tickets"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
attribute {
    name = "id"
    type = "S"
  }
}
~~~
### .env
* bea.env
~~~.env
PORT=5000
AWS_REGION=us-east-1
BEDROCK_AGENT_ID=<seu-bedrock-agent-id>
BEDROCK_AGENT_ALIAS_ID=<seu-bedrock-agent-alias-id>
OPENAI_API_KEY=<sua-chave-api-openai>
OPENAI_ASSISTANT_ID=<seu-id-assistente-openai>
~~~

* fea.env
~~~.env
VITE_API_BASE_URL=http://<seu-ip-ec2>:5000/api
~~~

### Dockerfile  
* dockerfile bea 
~~~dockerfile
FROM node:18
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 5000
CMD ["npm", "start"]
~~~

* dockerfile fea
~~~dockerfile
FROM node:16-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build
FROM node:16-alpine
WORKDIR /app
RUN npm install -g serve
COPY --from=build /app/dist /app
ENV PORT=5001
ENV NODE_ENV=production
EXPOSE 5001
CMD ["serve", "-s", ".", "-l", "5001"]
~~~
### Docker

* Para construir e executar a imagem Backend
~~~sh
docker build -t lab1-backend .
docker run -d -p 5000:5000 --env-file .env lab1-backend
~~~

* Para construir e executar a imagem Frontend
~~~sh
docker build -t lab1-frontend .
docker run -d -p 5001:5001 lab1-frontend
~~~

### Por fim, foi configurado as portas para regras de Firewall e poder acessar a aplicação;
