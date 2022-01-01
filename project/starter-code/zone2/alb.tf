 module "alb-zone1" {
    source             = "./modules/alb"
    alb_subnets        = data.terraform_remote_state.vpc.outputs.public_subnet_ids
    vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
    instance_ids       = module.project_ec2.aws_instance
    security_groups    = resource.aws_security_group.alb_sg.id
 } 

resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {    
    description = "web port"
    from_port   = 80    
    to_port     = 80
    protocol    = "tcp"    
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_sg"
  }
}