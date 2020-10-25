provider "aws"{
    region = "eu-west-1"
}
resource "aws_db_instance" "first_rds" {
    name = "rds1" # name of the database
    identifier = "first-rds" # unique identifier of ec2 instance
    instance_class = "db.t2.micro"
    engine = "mysql"
    engine_version = "8.0.20"
    username = "user1"
    password = "pass" # to change secret injection 
    port = 3306
    allocated_storage = 20
    skip_final_snapshot = true

}