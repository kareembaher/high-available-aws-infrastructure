/***************************************/
/*Setup EFS FileSystem for ECS Hosts*/
/***************************************/
resource "aws_efs_file_system" "App" {
  creation_token   = "AppEFS"
  encrypted        = "true"
  performance_mode = "generalPurpose"
  tags = {
    Name = "AppEFS"
  }
}
resource "aws_efs_mount_target" "AppEFSWestATarget" {
  file_system_id  = aws_efs_file_system.App.id
  subnet_id       = aws_subnet.EU1-Pub1.id
  security_groups = [aws_security_group.EFS.id]
}
resource "aws_efs_mount_target" "AppEFSWestBTarget" {
  file_system_id  = aws_efs_file_system.App.id
  subnet_id       = aws_subnet.EU1-Pub2.id
  security_groups = [aws_security_group.EFS.id]
}
