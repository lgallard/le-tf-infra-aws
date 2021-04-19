locals {
  cluster_name = "${var.project}-${var.environment}-eks-demoapps"

  # Network Local Vars
  # https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html
  # Important
  # Docker runs in the 172.17.0.0/16 CIDR range in Amazon EKS clusters. We recommend that your cluster's VPC subnets do
  # not overlap this range. Otherwise, you will receive the following error:
  # Error: : error upgrading connection: error dialing backend: dial tcp 172.17.nn.nn:10250: getsockopt: no route to host
  vpc_name = "${var.project}-${var.environment}-vpc-eks-demoapps"

  # Ref: https://www.davidc.net/sites/default/subnets/subnets.html?network=172.19.16.0&mask=20&division=15.7231
  vpc_cidr_block = "172.19.16.0/20"
  azs = [
    "${var.region}a",
    "${var.region}b",
    "${var.region}c",
  ]

  private_subnets = [
    "172.19.16.0/23",
    "172.19.18.0/23",
    "172.19.20.0/23",
  ]

  public_subnets = [
    "172.19.24.0/23",
    "172.19.26.0/23",
    "172.19.28.0/23",
  ]

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }

  # We need these so that k8s aws cloud provider recognizes our private subnets
  # and associates them to any load balancer that is created
  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }
}

locals {
  network_acls = {
    #
    # Allow / Deny VPC private subnets inbound default traffic
    #
    default_inbound = [
      {
        rule_number = 900 # Allow NTP
        rule_action = "allow"
        from_port   = 123
        to_port     = 123
        protocol    = "udp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 910 # Do not allow TCP low ports (0-1024)
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "tcp"
        cidr_block  = "0.0.0.0/0"
      },
      {
        rule_number = 920 # Do now allow UDP low ports (0-1024)
        rule_action = "allow"
        from_port   = 1024
        to_port     = 65535
        protocol    = "udp"
        cidr_block  = "0.0.0.0/0"
      },
    ]

    #
    # Allow VPC private subnets inbound traffic
    #
    private_inbound = [
      {
        rule_number = 100 # Allow traffic from Pritunl VPN server
        rule_action = "allow"
        from_port   = 0
        to_port     = 65535
        protocol    = "all"
        cidr_block  = "${data.terraform_remote_state.tools-vpn-server.outputs.instance_private_ip}/32"
      },
      {
        rule_number = 110 # Allow traffic from Shared private subnet A
        rule_action = "allow"
        from_port   = 0
        to_port     = 65535
        protocol    = "all"
        cidr_block  = data.terraform_remote_state.shared-vpc.outputs.private_subnets_cidr[0]
      },
      {
        rule_number = 120 # Allow traffic from Shared private subnet B
        rule_action = "allow"
        from_port   = 0
        to_port     = 65535
        protocol    = "all"
        cidr_block  = data.terraform_remote_state.shared-vpc.outputs.private_subnets_cidr[1]
      },
      {
        rule_number = 200 # Allow traffic from EKS VPC private subnet A
        rule_action = "allow"
        from_port   = 0
        to_port     = 65535
        protocol    = "all"
        cidr_block  = local.private_subnets[0]
      },
      {
        rule_number = 210 # Allow traffic from EKS VPC private subnet B
        rule_action = "allow"
        from_port   = 0
        to_port     = 65535
        protocol    = "all"
        cidr_block  = local.private_subnets[1]
      },
      {
        rule_number = 220 # Allow traffic from EKS VPC private subnet C
        rule_action = "allow"
        from_port   = 0
        to_port     = 65535
        protocol    = "all"
        cidr_block  = local.private_subnets[2]
      },
      {
        rule_number = 300 # vault hvn vpc
        rule_action = "allow"
        from_port   = 0
        to_port     = 65535
        protocol    = "all"
        cidr_block  = var.vpc_vault_hvn_cird
      },
    ]
  }
}