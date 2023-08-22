TERRAFORM
-----------

### how to maintaining version in terraform
![refer here](D:\terraform\required_version)
![preview](images/terraform1.png)
![preview](images/terraform2.png)

### how to create a REGION,VPC and SUBNET
#### manul steps
![preview](images/terraform15.png)
![preview](images/terraform16.png)
![preview](images/terraform17.png)
![preview](images/terraform18.png)
![preview](images/terraform19.png)
![preview](images/terraform20.png)

### FROM TERRAFORM
```yml

provider "aws" {
  region = "eu-west-2"
}
resource "aws_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "vpc"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.0.0/24"
  tags = {
    Name = "subnet"
  }
}

```
Now we have to follow below command
### terraform init : Intitalising the provider
![preview](images/terraform3.png)
![preview](images/terraform4.png)
### terraform fmt : check the alignment correct ot not
![preview](images/terraform5.png)
### terraform validate: your syntax is correct or not
![preview](images/terraform6.png)
### terraform plan: it will shows preview what you want creating after the apply creating resources
![preview](images/terraform7.png)
![preview](images/terraform8.png)
### terraform apply : it will creating infrastruture
![preview](images/terraform9.png)
![preview](images/terraform10.png)
### terraform apply -auto-approve :what you want creating resources before.it will not asking yes or no . directly creating infrastruture
![preview](images/terraform11.png)
### terraform destroy: destroying or deleting the infrastruture
![preview](images/terraform14.png)
### letus check cloud in your region it will creating resources or not
![preview](images/terraform12.png)
![preview](images/terraform13.png)

## we have to create ONE VPC and THREE SUBNETS

### create VPC
![preview](images/terraform21.png)
![preview](images/terraform22.png)
![preview](images/terraform23.png)
### create three SUBNETS with attached VPC
![preview](images/terraform24.png)
![preview](images/terraform25.png)
![preview](images/terraform26.png)
![preview](images/terraform27.png)
### successfully creating three Subnents with attached  After we were created VPC
![preview](images/terraform28.png)

### IN TERRAFORM

#### Order of execution in `terraform init,fmt,validate,plan,apply`

![preview](images/terraform29.png)
![preview](images/terraform30.png)
![preview](images/terraform31.png)
![preview](images/terraform32.png)
![preview](images/terraform33.png)

#### let'us check it will creating or not in my cloud

![preview](images/terraform34.png)
![preview](images/terraform35.png)

 ####  letus delteing my resources
  ![preview](images/terraform36.png)
  ![preview](images/terraform37.png)
  ![preview](images/terraform38.png)

### you can observe it will ask your deleting your resources `yes or no`
  ![preview](images/terraform39.png)
### letus check my resources it was deleted or not in my cloud

  ![preview](images/terraform40.png)


## VARIBLES

### how to pass the varible
####  main.tf
```yml 
provider "aws" {
  region = var.region
}

resource "aws_vpc" "ntier" {
    cidr_block = var.ntier_vpc_range
    tags = {
        Name = var.ntier_vpc_name
    }
  
}



resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.ntier.id # implicit dependecies
  cidr_block = var.ntier_sunbet1_range
  availability_zone = "${var.region}${var.second_availability_zone}"
  tags = {
    Name = var.ntier_tag1_name
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.ntier.id  # implicit dependecies
  cidr_block = var.ntier_subnet2_range
  availability_zone = "${var.region}${var.second_availability_zone}"
  tags = {
    Name = var.ntier_tag2_name
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id     = aws_vpc.ntier.id   # implicit dependecies
  cidr_block = var.ntier_subnet3_range
  availability_zone = "${var.region}${var.third_availability_zone}"
  tags = {
    Name = var.ntier_tag3_name
  }
}

```

#### inputs.tf

```yml

variable "region" {
    type = string
    default = "eu-west-2"
    description = "region to create rources"
  
}

variable "ntier_vpc_range" {
    type = string
    default = "10.10.0.0/16"
    
    description = "Vpc cidr Range"
  
}

variable "ntier_sunbet1_range" {
  
  type = string
  default = "10.10.0.0/24"
  description = "Subnet1 cidr range"
}

variable "ntier_subnet2_range" {
    type = string
    default = "10.10.1.0/24"
    description = "subnet2 cidr range"
  
}


variable "ntier_subnet3_range" {
    type = string
    default = "10.10.2.0/24"
    description = "subnet3 cidr range"
  
}

variable "ntier_vpc_name" {
    type = string
    default = "vpc"
    description = "vpc tag name"
  }

variable "ntier_tag1_name" {
    type = string
    default = "subnet1"
    description = "subnet1 tag name"
  
}

variable "ntier_tag2_name" {
    type = string
    default = "subnet2"
    description = "subnet2 tag name"
  
}

variable "ntier_tag3_name" {
  type = string
  default = "subnet3"
  description = "subnet3 tag name"
}

variable "first_availability_zone" {
    type = string
    default = "a"
  
}

variable "second_availability_zone" {
    type = string
    default = "b"
  
}

variable "third_availability_zone" {
    type = string
    default = "c"
  
}

```

#### values.tf

```yml
region = "us-east-1"
ntier_vpc_range = "192.168.0.0/16"
ntier_sunbet1_range = "192.168.0.0/24"
ntier_subnet2_range = "192.168.1.0/24"
ntier_subnet3_range = "192.168.2.0/24"

```

![preview](images/pip1.png)
![preview](images/pip2.png)





