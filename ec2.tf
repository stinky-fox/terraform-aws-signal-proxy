###########################################################
#                                                         #
#       Scripter: Stinky-Fox                              #
#       About: Bring the EC2 instance and create          #
#              a respective Route 53 record               #
#       Usage: Define variables in vars.tf                #
#       Version : 1.0                                     #
#                                                         #
###########################################################

###################################################
#                                                 #      
#   Create  EC2 machine from predefined AMI       #
#                                                 #  
###################################################

## Signal TLS Proxy EC2 instances

resource "aws_instance" "signalProxyServer" {

    ami                         = data.aws_ami.al2_arm64.id
    instance_type               = var.instanceSize
    associate_public_ip_address = true
    vpc_security_group_ids      = [aws_security_group.ec2_signal_sg.id]
    subnet_id                   = aws_subnet.signal_vpc_subnet_a.id
    key_name                    = aws_key_pair.myPKI.key_name
    user_data                   = file("user-data.sh")

    tags    =   {
            
            Name        = "Signal-TLS-Proxy"
            Hostname    = var.instanceName
    }

}

###################################################
#                                                 #      
#      Create respective Route 53 records         #
#      !! This is a public hosted zone !!         # 
#                                                 #  
###################################################


## Public FQDN 
resource "aws_route53_record" "signalProxyServerPublicFQDN" {

  zone_id = var.publicZoneId
  name    = var.instanceName
  type    = "A"
  ttl     = "3600"
 records = [aws_instance.signalProxyServer.public_ip]
}
