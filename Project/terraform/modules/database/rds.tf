
resource "aws_db_subnet_group" "testdb_subnet_group" {
  name       = var.identifier
  subnet_ids = var.private_subnet_id
}

resource "aws_db_instance" "testdb" {
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class

  username             = var.username
  password             = var.password

  identifier           = var.identifier

  db_subnet_group_name = aws_db_subnet_group.testdb_subnet_group.name
  availability_zone = var.availability_zone

  parameter_group_name = var.group_name
  skip_final_snapshot  = var.skip_final_snapshot
}
