###########################################################
#                                                         #
#       Scripter: Stinky-Fox                              #
#       About: Create networking configurations           #
#              VPC, IGW, and Security Groups              #
#       Usage: Define variables in vars.tf                #
#       Version : 1.0                                     #
#                                                         #
###########################################################

###################################################
#                                                 #      
#        Create a spare VPC per each Lab          #
#                                                 #  
###################################################

resource "aws_vpc" "signal_vpc" {

    cidr_block              = "192.168.0.0/16"
    instance_tenancy        = "default"
    enable_dns_hostnames    = true
    enable_dns_support      = true


    tags    = {

            Name    = var.vpcName
    }
}

###################################################
#                                                 #      
#        Each VPC should have an IGW              #
#                                                 #  
###################################################

resource "aws_internet_gateway" "signal_gw" {

    vpc_id          = aws_vpc.signal_vpc.id

    tags    = {

            Name    = "igw-signal-proxy"
    }
}

###################################################
#                                                 #      
#        Create a routing table                   #
#                                                 #  
###################################################

resource "aws_route_table" "main_subnet_route" {

    vpc_id          = aws_vpc.signal_vpc.id
    route {

        cidr_block = "0.0.0.0/0"
        gateway_id  = aws_internet_gateway.signal_gw.id
    }

    tags    = {

            Name    = "route-signal-proxy"
    }

}

###################################################
#                                                 #      
#   Associate routing table with IGW as default   #
#                                                 #  
###################################################

resource "aws_main_route_table_association" "main_vpc_main_route" {

    vpc_id          = aws_vpc.signal_vpc.id
    route_table_id  = aws_route_table.main_subnet_route.id

}

###################################################
#                                                 #      
#   Create subnet for VPC                         #
#                                                 #  
###################################################

resource "aws_subnet" "signal_vpc_subnet_a" {

    cidr_block                                  = "192.168.254.0/24"
    availability_zone                           = "${var.awsRegion}a"
    vpc_id                                      = aws_vpc.signal_vpc.id
    enable_resource_name_dns_a_record_on_launch = true
    
    tags    = {

            Name    = "subnet-signal-proxy"
    }
}

###################################################
#                                                 #      
#   Create security groups for EC2                #
#                                                 #  
###################################################

## EC2 security group configuration
resource "aws_security_group" "ec2_signal_sg" {

    vpc_id              = aws_vpc.signal_vpc.id

### specify ingress connection ports

    #### SSH listening port accepting connections from Trusted IP
    ingress {

        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.myIP]

    }
    #### HTTPS listening port

    ingress {

        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #### HTTP listening port

    ingress {

        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


### specify egress connection ports
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags    = {

            Name    = "signal-access-group"
    }
}
