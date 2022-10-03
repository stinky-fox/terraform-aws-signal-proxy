###########################################################
#                                                         #
#       Scripter: Stinky-Fox                              #
#       About: Search for AMI
#       Usage: Define variables in vars.tf                #
#       Version : 1.0                                     #
#                                                         #
###########################################################


data "aws_ami" "al2_arm64" {

    owners = ["amazon"]
    most_recent = true
    filter {

        name = "name"
        values = ["*amzn2-ami-kernel-*-hvm-2.0*x86*"]
    }
}