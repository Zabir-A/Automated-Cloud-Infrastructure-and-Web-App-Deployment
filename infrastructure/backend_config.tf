terraform {
    backend "s3" {
        bucket         = "zabir-a-mod-demo-sol-tf-state-2023-12"
        key            = "terraform.tfstate"
        dynamodb_table = "zabir-a-mod-demo-sol-tf-state-lock-2023-12"
        region         =  "us-west-2" 
        encrypt        = true
    }
}
