
#  ami           = "ami-08b66c1b6d6a8a30a" # Replace with the Windows Server 2022 AMI ID
#  ami           = "ami-08b66c1b6d6a8a30a" # Replace with the Second Windows Server 2022 AMI
#  ami           = "ami-0901bbd9d6e996fb7" # Replace with the Netspectrum AMI ID
#  ami           = "ami-04911b1f694f455b8" # Replace with the Kali Linux AMI ID
#  key           = "DesktopKey-US-EAST-2"

variable "region" {
    default="us-east-2"
}

variable "public_subnet_cidr" {
    default = "10.0.1.0/24"
}

variable "aws-key" {
    description = "SSH Public Key Name Created in AWS (keys are unique per region)."
    type = string
    default = "US-EAST-2-KEY"

}
