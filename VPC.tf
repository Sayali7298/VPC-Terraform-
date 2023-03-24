variable "project_id" {i-013da97433266c784}
variable "region" {us-east-1}
variable "vpc_name" {project}
variable "subnet_name_private" {project-subnet-private2-us-east-1b}
variable "subnet_name_public" {project-subnet-public2-us-east-1b}
variable "vm_name" {Project_aws}


resource "aws-vpc-resource" "vpc_network" {
  name= var.project-vpc
  auto_create_subnetworks = false
}

resource "aws_vpc_resource" "project-subnet-private2-us-east-1b" {
  name          = var.project-subnet-private2-us-east-1b
  network       = aws-vpc-resource.vpc_network
  ip_cidr_range = "10.0.144.0/20"
  region        = var.us-east-1
}

resource "aws_subnetwork" "project-subnet-public1-us-east-1a" {
  name          = var.project-subnet-public1-us-east-1a
  network       =  aws-vpc-resource.vpc_network
  ip_cidr_range = "10.0.16.0/20"
  region        = var.us-east-1
}

resource "aws_router_nat" "Project_NAT" {
  name               = "Project_NAT"
  router             = aws_router.rtb-02e203d4149558ec2
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = ["${aws_subnetwork.10.0.144.0/20}"]
}

resource "aws_instance" "Project_aws
" {
  name         = var.Project_aws
  machine_type = "t2-micro"
  zone         = "${var.us-east-1}-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    subnetwork = aws_subnetwork.subnet-0700780344e6eafab
  }
}

