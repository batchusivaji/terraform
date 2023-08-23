TERRAFORM
-----------

### how to maintaining version in terraform
[[click here]](required_version/version.tf)
![preview](images/terraform1.png)
![preview](images/terraform2.png)

### how to create a VPC and SUBNET
#### manul steps
![preview](images/terraform15.png)
![preview](images/terraform16.png)
![preview](images/terraform17.png)
![preview](images/terraform18.png)
![preview](images/terraform19.png)
![preview](images/terraform20.png)

### FROM TERRAFORM
[[click here]](vpc)
* Now we have to follow below command
### terraform init : Intitalising the provider
![preview](images/terraform3.png)
![preview](images/terraform4.png)
### terraform fmt : check it alignment correct or not
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
### from TERRAFORM
[[click here]](subnets/multiple_subnets/)
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
[[click here]](subnets/multiple_subnets_variables/)

![preview](images/terraform42.png)
![preview](images/terraform43.png)


### Count function
[[click here]](count_function)

![preview](images/terraform44.png)

### length fuction and cidr subnet
[[click here]](length_function&cidrsubnet_network_function)

![preview](images/terraform45.png)

### create private and public subnets
[[click here]](private&public_subnets)

![preview](images/terraform46.png)

### security group reusability
[[click here]](aws-reusability-securitygroup)

![preview](images/terraform47.png)

### create instance
#### manual steps
[[click here]](instance)

![preview](images/terraform47.png)
![preview](images/terraform48.png)
![preview](images/terraform49.png)
![preview](images/terraform51.png)
![preview](images/terraform52.png)
![preview](images/terraform53.png)
![preview](images/terraform55.png)
![preview](images/terraform56.png)


### from terraform
![preview](images/terraform57.png)

## create Data base instance
 ### manual steps
 ![preview](images/terraform58.png)
 ![preview](images/terraform59.png)
 ![preview](images/terraform60.png)
 ![preview](images/terraform61.png)
 ![preview](images/terraform62.png)
 ![preview](images/terraform63.png)


### from terraform 

