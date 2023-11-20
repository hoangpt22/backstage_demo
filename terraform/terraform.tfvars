# General
project = "backstage-demo"
default_region = "ap-southeast-2"
vpc_cidr_block = "172.31.0.0/16"
public_subnets = {
  "ap-southeast-2a" = "172.31.0.0/20",
  "ap-southeast-2b" = "172.31.16.0/20"
}
