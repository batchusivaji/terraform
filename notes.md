TERRAFORM
-----------

what is terraform
-------------------
Terraform is an open-source infrastructure as a code tool created by HashiCorp, that lets you provision, build, change, and version cloud and on-prem resources. It lets you define both Cloud and on-prem resources in human-readable configuration files that you can version, reuse, and share.
### infrastructure as a code
 with the code we can manage the infrastructure
  
## terraform commands
----------------------

### Check version:
 terraform version
### terraform init:
This command will check the configuration file and initialize the working directory containing the .tf file and install the required plugins for the provider.
### terraform plan:
This command lets you preview the actions Terraform would take to modify your infrastructure or save a speculative plan which you can apply later.
### terraform validate:
This command will show whether the syntax used is correct or not 
### terraform fmt:
This command scans the configuration files in the current working directory and formats the code. It is used to improve the readability of files.   
### terraform apply:
This command executes the actions proposed in a terraform plan. It is used to deploy your infrastructure. Typically apply should be run after terraform init and terraform plan. Enter yes when prompted "Enter a value:"
### terraform destroy: 
 destroy the infrastructure
### terraform show:
This command it` will shows the resources we have created`
### Command Order of Execution:
refresh, plan, make a decision, apply
### terraform provider:
This command will list all the providers used in the `configuration file`
### terraform providers mirror /<file_path>
This command will mirror the provider configuration in a new path.
### terraform taint:
The terraform taint command manually marks a `Terraform-managed resource as tainted, forcing it to be destroyed and recreated on the next apply.`
### terraform untaint:  
The terraform untaint command manually unmarks a Terraform-managed resource as tainted, `restoring it as the primary instance in the state. `
### terraform refresh:
Update local state file against real resources in cloud
### Desired State:
Local Terraform Manifest (All *.tf files)
### current state:
Real Resources present in your cloud
### terraform output:
This command will `print all the output variables in the configuration files`
## Terraform State List and Show commands
* These two commands comes under Terraform Inspecting State
### terraform state list: 
This command is used to list resources within a Terraform state
### terraform state show: 
This command is used to show the attributes of a single resource in the Terraform state.
### What is Terraform state file?
When we create infrastructure after executing "terraform apply" command. Terraform creates a state file called terraform.tfstate this state file contains all the information about the resources created using Terraform. This state file keeps track of resources created by your configuration and maps them to real-world resources. The state file is a sensitive file as it contains information about the infrastructure that we have created. You should never push this file to any version control system like GitHub. Store terraform.tfstate file in the backend to keep it safe.

## Terraform State pull / push command
This command comes under Terraform Disaster Recovery Concept
### terraform state pull:
The terraform state pull command is used to manually download and output the state from remote state.
This command also works with local state.
This command will download the state from its current location and output the raw format to stdout.
### terraform state push: 
The terraform state push command is used to manually upload a local state file to remote state
### The backend supported by Terraform:
-------------------------------------
  - Amazon S3
  - HashiCorp’s Terraform Cloud and Terraform Enterprise.
  - Azure Storage
  - Google Cloud Storage
### Variables in terraform
-----------------------
variables can be defined in variables.tf file and can be used in configuration files as var.variable_name 
### Types of variables
------------------  
  - string ("file")
  - bool (true/false)
  - number (7)
  - any (Default value)

- The type constructors allow you to specify complex types such as collections:
  - list()
  - set()
  - map()
  - object({ = , ... })
  - tuple([, ...]) 
- How to define variables in variables.tf file using a parameter (default, type, and description)
- To pass variables while executing commands we have two options
  - -var
  - -var-file 
```yaml
   variable "filename" {
   deafult = "test"
   type = string
   description = "configuration file name"
   } 
 
```
### Terraform Lifecycle Rule:
This is used in the configuration file when you don't want your resources to delete before the creation of new resources
```yml
lifecycle {
   create_before_destroy = true
   }

```
* 
This is used in the configuration file when you don't want your old resources to be deleted
```yml
lifecycle {
   prevent_destroy = true
   }
```

### Create aliases

```yml
provider "aws" {
   region = "us-east-1"
   alias = "east"
   }
   
   use it -- aws.east
```

### Output Variables in Terraform:

Output variables are used to store the value of the expression in terraform
```yml
output "public_ip_addr" {
   value = aws_instance.jenkinsserver.public_ip
   description = "print public ipv4 of Jenkis Server"
   }
```
* If one resource is dependent on another and we want that resource to be provisioned before use depends_on

```yml
depends_on = [
     aws_instance.jenkins
     ]
```

## Terraform Implicit and Explicit Dependencies

### Implicit Dependencies:

* Implicit dependencies, like their names suggest, `are automatically detected by Terraform.` 
  * For example, in the code below,their implicit dependecies between the network interface and the virtual machine, because the VM resource uses the network interface id

```yml 
resource "azurerm_virtual_machine" "vm" {
  
  network_interface_ids = [azurerm_network_interface.nic.id]

}

```

### Explicit Dependencies

Sometimes there are dependencies between `resources that are not visible to Terraform`. The `depends_on argument is accepted by any resource and accepts a list of resources to create` explicit dependencies for.

```yml
# New resource for the S3 bucket our application will use.
resource "aws_s3_bucket" "example" {
  #NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
  # this name must be changed before applying this example to avoid naming
  # conflicts.
  bucket = "terraform-getting-started-guide"
  acl    = "private"
}

# Change the aws_instance we declared earlier to now include "depends_on"
resource "aws_instance" "example" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"

  # Tells Terraform that this EC2 instance must be created only after the
  # S3 bucket has been created.
  depends_on = [aws_s3_bucket.example]
}

```
