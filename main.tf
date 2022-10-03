###########################################################
#                                                         #
#       Scripter: Stinky-Fox                              #
#       About: Terraform script to run a                  #
#              Signal Proxy in  AWS                       #
#       Usage: Define variables in vars.tf                #
#       Version : 1.0                                     #
#                                                         #
###########################################################

###################################################
#                                                 #      
#        Configure AWS provider credentials       #
#                                                 #  
###################################################

provider "aws" {

    region      = var.awsRegion
    access_key  = var.awsAccessKey
    secret_key  = var.awsSecretKey

}

###################################################
#                                                 #      
#       Load the private key from local file      #
#                                                 #  
###################################################

resource "aws_key_pair" "myPKI" {

    key_name        = var.keyName
    public_key      = file(var.publicKeyPath)
}