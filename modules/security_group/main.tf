
resource "aws_security_group" "sg" {
  vpc_id = var.sg_vpc_id
}
