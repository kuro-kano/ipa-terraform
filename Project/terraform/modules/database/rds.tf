
resource "aws_db_instance" "testdb" {
  allocated_storage = var.allocated_storage
  db_name           = var.db_name
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class

  username = var.username
  password = var.password

  identifier = var.identifier

  availability_zone = var.availability_zone

  parameter_group_name = var.group_name
  skip_final_snapshot  = var.skip_final_snapshot
}
