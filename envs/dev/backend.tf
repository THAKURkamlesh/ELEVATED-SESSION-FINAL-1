terraform {
  backend "s3" {
    bucket = "my-unique-tf-state-bucket-123456"
    #key    = "global/s3/terraform.tfstate"
    # key      =  "user3/global/s3/terraform.tfstate"   
    #key      =  "user01/global/s3/terraform.tfstate"  


    key      =  "user01/global/terr/terraform.tfstate"
    region = "us-east-1"

    profile = "user1"
  }
}

