terraform {
    backend s3 {
        bucket = "remote-bucket"
        key = "terraform/tfstate.tfstate"
        region = "eu-west-1"
        access_key = ""
        secret_key = ""

    }
}