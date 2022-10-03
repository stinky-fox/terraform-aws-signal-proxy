###########################################################
#                                                         #
#       Scripter: Stinky-Fox                              #
#       Usage: Define variables and their default values  #
#       Version : 1.0                                     #
#                                                         #
###########################################################

###################################################
#       provider specific variables               #
###################################################

variable "awsRegion" {

    type        = string
    description = "AWS region to use"
    default     = "us-east-2"
}

variable "awsAccessKey" {

    type        = string
    description = "AWS Access Key"

}

variable "awsSecretKey" {

    type        = string
    description = "AWS Secret key"

}


###################################################
#               misc variables                    #
###################################################

variable "publicKeyPath" {

    type        = string
    description = "path to public key"
    default     = "id_rsa.pub"
}

variable "publicZoneId" {
    type        = string
    description = "zoneID in Route 53"
}

variable "myIP"  {
    type        = string
    description = "Your IP address in format X.X.X.X/X"
}

###################################################
#            EC2 specific variables               #
###################################################


variable "instanceSize" {

    type        = string
    description = "Instance type for Amazon Linux 2"
    default     = "t2.micro"
}

variable "instanceName" {

    type        = string
    description = "Define a public name for this server. Defaut is a tribute to Monica Bellucci and her role in The Matrix movie"
    default     = "persephone"
}

###################################################
#                Misc variables                   #
###################################################

variable "vpcName" {
    type        = string
    description = "Define a VPC name. Default is a tribute to the Ghost in the Shell japanese manga/anime."
    default = "section-nine"
}

variable "keyName" {
    type        = string
    description = "Define a key name that will be used. Default is a tribute to the main cyborg character in the Ghost in the Shell japanese manga/anime"
    default     = "Motoko Kusanagi"
}