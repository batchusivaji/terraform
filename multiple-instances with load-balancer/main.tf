provider "aws" {
  region = var.region
}
### Create Vpc

resource "aws_vpc" "ntier" {
  cidr_block = var.ntier-vpc-info.vpc_cidr
  tags = {
    Name = "ntier-vpc"
  }
}
### Create Subnet

resource "aws_subnet" "subnets" {
  count             = length(var.ntier-vpc-info.subnet-tag-names)
  vpc_id            = aws_vpc.ntier.id
  cidr_block        = cidrsubnet(var.ntier-vpc-info.vpc_cidr, 8, count.index)
  availability_zone = "${var.region}${var.ntier-vpc-info.subnet-availability_zones[count.index]}"
  tags = {
    Name = var.ntier-vpc-info.subnet-tag-names[count.index]
  }

  depends_on = [aws_vpc.ntier]
}
### Internet gateway
resource "aws_internet_gateway" "ig" {
  vpc_id     = aws_vpc.ntier.id
  depends_on = [aws_subnet.subnets]
}

### Route table 
resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.ntier.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id

  }
  tags = {
    Name = "route-table"
  }
  depends_on = [aws_internet_gateway.ig]
}
### Route table association

resource "aws_route_table_association" "route_association" {
  subnet_id      = aws_subnet.subnets[0].id
  route_table_id = aws_route_table.route-table.id
  depends_on     = [aws_route_table.route-table]

}

resource "aws_route_table_association" "route_association_1" {
  subnet_id      = aws_subnet.subnets[1].id
  route_table_id = aws_route_table.route-table.id
  depends_on     = [aws_route_table.route-table]
}

resource "aws_route_table_association" "route_association_2" {
  subnet_id      = aws_subnet.subnets[2].id
  route_table_id = aws_route_table.route-table.id
  depends_on     = [aws_route_table.route-table]
}

### Security group


resource "aws_security_group" "sg" {
  name   = "allow all ports"
  vpc_id = aws_vpc.ntier.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


### Create Instances


resource "aws_instance" "apache2" {
  instance_type               = "t2.micro"
  associate_public_ip_address = "true"
  ami                         = "ami-0eb260c4d5475b901"
  key_name                    = "compute"
  subnet_id                   = aws_subnet.subnets[0].id
  user_data                   = file("apache2.sh")
  vpc_security_group_ids      = [aws_security_group.sg.id]
  tags = {
    Name = "apache2"
  }
  depends_on = [aws_security_group.sg]

}


resource "aws_instance" "nginx" {
  instance_type               = "t2.micro"
  associate_public_ip_address = "true"
  ami                         = "ami-0eb260c4d5475b901"
  key_name                    = "compute"
  subnet_id                   = aws_subnet.subnets[1].id
  user_data                   = file("nginx.sh")
  vpc_security_group_ids      = [aws_security_group.sg.id]
  tags = {
    Name = "nginx"
  }
  depends_on = [aws_security_group.sg]

}

resource "aws_instance" "tomcat9" {
  instance_type               = "t2.medium"
  associate_public_ip_address = "true"
  ami                         = "ami-0eb260c4d5475b901"
  key_name                    = "compute"
  subnet_id                   = aws_subnet.subnets[2].id
  user_data                   = file("tomcat9.sh")
  vpc_security_group_ids      = [aws_security_group.sg.id]
  tags = {
    Name = "tomcat9"
  }
  depends_on = [aws_security_group.sg]

}


### create target group

resource "aws_lb_target_group" "target-group" {
  name     = "target-group"
  port = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ntier.id
  health_check {
    enabled = true
    healthy_threshold = 3
    interval = 6
    matcher = "200-499"
    path = "/"
    protocol = "HTTP"
    timeout = 5
    unhealthy_threshold = 2
  }
}


## create target group attachement

resource "aws_lb_target_group_attachment" "target-group-attachment" {
  count            = 1
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = aws_instance.apache2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "target-group-attachment-1" {
  count            = 1
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = aws_instance.nginx.id
  port             = 80
}


resource "aws_lb_target_group_attachment" "target-group-attachment-2" {
  count            = 1
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = aws_instance.tomcat9.id
  port             = 8080
}

resource "aws_lb" "loadbalancer" {
  name                       = "load-balancer"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.sg.id]
  subnets                    = [aws_subnet.subnets[0].id, aws_subnet.subnets[1].id, aws_subnet.subnets[2].id]
  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}


### create Load Balancer Listener 

resource "aws_lb_listener" "lb-listener-1" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}

resource "aws_lb_listener" "lb-listener-2" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = 8080
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}


  

