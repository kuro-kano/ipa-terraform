
resource "aws_db_subnet_group" "testdb_subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.private_subnet_ids
}

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

  db_subnet_group_name = aws_db_subnet_group.testdb_subnet_group.name

  parameter_group_name = var.group_name
  skip_final_snapshot  = var.skip_final_snapshot
}
